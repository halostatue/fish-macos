# halostatue/fish-macos

[![Version][version]](https://github.com/halostatue/fish-macos/releases)

Useful functions for macOS using [fish shell][fish].

## Installation

Install with [Fisher][fisher]:

```fish
fisher install halostatue/fish-macos@v7
```

### System Requirements

- [fish][fish] 3.4+

Compatibility with macOS versions is maintained on a rolling basis. When
possible, _backwards_ compatibility will be maintained as long as the
functionality is _possible_ in later versions of macOS. Functions and
subcommands may be removed if they are no longer supported on the latest
versions of macOS. This will always trigger a major version release.

## Functions

### `app`

Utilities for working with MacOS apps. Has the following subcommands:

#### `app bundleid`

Shows the bundle identifier for each of the applications found for the pattern
(see `app find` for how applications are found).

##### Options

- `-x`, `--exact`: Perform exact matches only
- `-a`, `--all`: Show all matches
- `-q`, `--quiet`: Suppress error output
- `-s`, `--short`: Prints out the bundle IDs only

##### Examples

```console
$ app bundleid 1password
/Applications/1Password for Safari.app: com.1password.safari
/Applications/1Password.app: com.1password.1password

$ app bundleid -x 1password
/Applications/1Password.app: com.1password.1password
```

#### `app find`

Shows installed apps by the provided pattern or patterns. Searches for apps in
`/Applications`, `/Applications/Setapp`, `/Applications/Utilities`,
`~/Applications`, `/Appliciations/Xcode.app/Contents/Applications`,
`/Developer/Applications`, and `/System/Applications`.

##### Options

- `-x`, `--exact`: Perform exact matches only
- `-a`, `--all`: Show all matches
- `-q`, `--quiet`: Do not print matches

##### Examples

```console
$ app find -a 1password
/Applications/1Password for Safari.app
/Applications/1Password.app

$ app find -x 1password
/Applications/1Password.app'
```

#### `app frontmost`

Shows the front-most application.

##### Options

- `-b`, `--bundle-id`: Shows the app bundle ID
- `-p`, `--path`: Shows the app path
- `-n`, `--name`: Shows the app name
- `-P`, `--pid`: Shows the PID of the app
- `-a`, `--all`: Shows all details

##### Examples

```console
$ app frontmost
iTerm2'
```

#### `app icon`

Extracts macOS app icons as PNG (see `app find` for how applications are found).

##### Options

- `-x`, `--exact`: Perform exact matches only
- `-oOUTPUT`: Output to the file or directory specified
- `--output OUTPUT`: Output to the file or directory specified
- `-wWIDTH`: Outputs to a maximum of WIDTH pixels
- `--width WIDTH`: Outputs to a maximum of WIDTH pixels

#### `app quit`

Quits apps identified by the provided pattern or patterns (see `app find` for
how applications are found).

##### Options

- `-x`, `--exact`: Quits only applications with exact matches
- `-r`, `--restart`: Restarts the application that was quit

### `finder`

Interacts with the Finder. If a window number parameter is accepted in a
command, the first (front-most) window is number `1`. If a lower window is
specified, or no window is specified, that window becomes the first window.

#### `finder track`

Makes the first Finder window track with the shell `$PWD`. This should be used
in a single shell instance only, and updates only when the `$PWD` value is
updated.

#### `finder untrack`

Disables Finder directory tracking.

#### `finder cd [window#]`

Changes the current path to that of the Finder window.

#### `finder pushd [window#]`

Changes the current path with `pushd` to that of the Finder window.

#### `finder pwd [window#]`

Print the current path of the Finder window.

#### `finder column [window#]`

Changes the Finder window to the current working directory (`$PWD`) using the
`column` view.

#### `finder icon [window#]`

Changes the Finder window to the current working directory (`$PWD`) using the
`icon` view.

#### `finder list [window#]`

Changes the Finder window to the current working directory (`$PWD`) using the
`list` view.

#### `finder update [window#]`

Changes the Finder window to the current working directory (`$PWD`) using the
current view.

#### `finder clean [path...]`

Removes `.DS_Store` files from the paths provided, or the current path if one is
not provided.

#### `finder hidden [off|on|toggle]`

Shows or hides hidden files in Finder. Accepts a parameter `on` (show the
files), `off` (hide the files), or `toggle`. If no parameter is given, shows the
current state.

#### `finder selected`

Prints a list of selected folders and files from Finder.

#### `finder quarantine [show]`

Shows quarantine events from quarantine databases.

#### `finder quarantine clear`

Clears quarantine events from quarantine databases.

#### `finder quarantine clean FILE...`

Cleans the named file(s) of quarantine extended attributes.

#### `finder desktop-icons [off|on|toggle]`

Shows or hides the desktop icons. Accepts a parameter `on` (show the files),
`off` (hide the files), or `toggle`. If no parameter is given, shows the current
state.

### `has_app`

Returns true if one or more of the named MacOS application exists. This is a
specialized wrapper around `app find` that always looks for exact matches.

This was called `has:app`, but has been renamed `has_app`. The previous versions
will be removed at version 6.

### `mac`

Manage various aspects of the modern MacOS interface.

#### `mac airdrop`

Works with the Mac AirDrop configurations. Has the following subcommands:

- `on`: Turns AirDrop on.
- `off`: Turns AirDrop off.
- `status`: Reports the status of AirDrop.

#### `mac airport`

Work with Mac AirPort configurations. Has the following subcommands:

- `scan`: Scans the current AirPort configurations.
- `ssid`: Prints the current AirPort network SSID.
- `history`: Prints the history of network connections.
- `on`: Turns AirPort `on`.
- `off`: Turns AirPort `off`.
- `password`: Recovers the current AirPort network password, or the password for
  a specified SSID.

#### `mac brightness`

Increase or decrease the brightness level. This uses system event key codes.
Supports `up` (increase brightness) and `down` (decrease brightness).

#### `mac flushdns`

Flush the MacOS DNS cache.

#### `mac font-smoothing`

Enables or disables font smoothing. If no apps are provided, sets the global
font smoothing preference. If apps are provided, font smoothing will be set for
each app. See `app bundleid` for how apps are resolved.

`mac font-smoothing [options] off|on [APP...]`

#### `mac lsclean`

Clean LaunchServices to remove duplicate 'Open with...' entries.

#### `mac mail`

Performs operations on Mail.app configuration and database. Before running
vacuum after any OS upgrade, Mail.app must have been opened at least once so
that the database and index formats have been updated.

Supported subcommands are:

- `vacuum`: Vacuums the envelope index to improve performance.
- `attachments inline`: Sets Mail.app attachment handling to inline.
- `attachments icon`: Sets Mail.app attachment handling to icon.

> This started as a process to speed up Mail.app by vacuuming the envelope index
> with a history from a October 2007 [blog post][hawkwings] by Tim Gaden on the
> Hawk Wings blog covering tips and tricks for Apple Mail. It turned into a
> script by [pmbuko][pmbuko] and Romulo and variously updated by Brett Terpstra
> (2012), Mathias Törnblom (2015), Andrei Miclaus (2017) before I ported it to
> Fish in 2022.

[hawkwings]: http://web.archive.org/web/20071008123746/http://www.hawkwings.net/2007/03/03/scripts-to-automate-the-mailapp-envelope-speed-trick/
[pmbuko]: https://github.com/pmbuko

#### `mac proxy-icon`

Enables or disables the visibility of the proxy icon without delay. macOS
versions older than Monterey always show the proxy icon.

States:

- `FLOAT`: Sets the display of the proxy icon to FLOAT fractional seconds.
- `off`: Sets the display of the proxy icon to default.
- `on` Sets the display of the proxy icon to 0 seconds.
- `[status]`: Shows the duration of the proxy icon display.
- `toggle`: Toggles the display of the proxy icon.

When displaying `status`, `-q` or `--query` can be used to suppress the output.

#### `mac serialnumber`

Gets the serial number for the current macOS device.

#### `mac touchid sudo`

Enables or disables Touch ID support for `sudo`. Requires administrative
permissions to edit `/etc/pam.d/sudo_local` and executes with `sudo`. If
`pam_reattach` is installed, this will be managed as well.

The following states may be specified:

- `off`: Disables Touch ID.
- `on`: Enables Touch ID.
- `[status]`: Shows the status of Touch ID.
- `toggle`: Toggles the status of Touch ID.

##### Notes

In v7 or later, `mac touchid sudo` only manages `/etc/pam.d/sudo_local`. It will
halt if either `pam_tid` or `pam_reattach` are present in `/etc/pam.d/sudo` or
if `/etc/pam.d/sudo` does not include `sudo_local`.

`/etc/pam.d/sudo_local` survives reboots and operating system upgrades, so as
long as the `pam_tid.so` and `pam_reattach.so` files are not missing or do not
work, nothing will be broken.

If something breaks while managing `/etc/pam.d/sudo_local`, recovery is easy:

1. `open /etc/pam.d`
2. Use ⌘⌫ in Finder on `sudo_local` to delete the file. Authenticate (possibly
   with Touch ID), and everything is fixed.

#### `mac transparency`

Enables or disables interface transparency by setting the universal access
"reduce transparency" setting.

Valid states are:

- `off`: Disables interface transparency
- `on`: Enables interface transparency
- `[status]`: Shows the status of interface transparency
- `toggle`: Toggles interface transparency

#### `mac version`

Shows the current macOS version.

Options include:

- `-s`, `--simple`: Removes spaces from the version displayed
- `-l`, `--lowercase`: Converts the version to all lowercase
- `-c`, `--comparable`: Outputs the comparable version value
- `-v`, `--version`: Outputs the macOS version (same as
  `sw_vers -productVersion`)'

#### `mac vol`

Set or show the Mac audio volume.

### `manp`

View a man page as a PDF via `Preview.app`. PDFs will be cached in
`/private/tmp/man PDFs` by default, but this can be overridden with the
universal variable `$manp_cache_path`. It will be opened with the default PDF
application by default unless `$manp_pdf_app_name` is set.

The cache can be cleared with `--clear-cache`.

### `note`

Add a note to Notes.app.

### `ql`

Quick Look a file from the command-line.

### `remind`

Add a note to Reminders.app.

## Licence

[MIT](./LICENCE.md)

## Change Log

[CHANGELOG](./CHANGELOG.md)

## Contributing

- [Contributing](./CONTRIBUTING.md)
- [Contributors](./CONTRIBUTORS.md)
- [Code of Conduct](./CODE_OF_CONDUCT.md)

[version]: https://img.shields.io/github/tag/halostatue/fish-macos.svg?label=Version
[fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
