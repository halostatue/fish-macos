# halostatue/fish-macos

Useful functions for macOS using [fish shell][fish].

[![Version][version]](https://github.com/halostatue/fish-macos/releases)

## Installation

Install with [Fisher][fisher]:

```fish
fisher install halostatue/fish-macos@v6
```

### System Requirements

- [fish][fish] 3.4+
- [fisher][fisher] 4.0+

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

### `has_app` (previously `has:app`)

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

#### `mac flushdns`

Flush the MacOS DNS cache.

#### `mac lock-screen`

Locks the screen.

#### `mac lsclean`

Clean LaunchServices to remove duplicate 'Open with...' entries.

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

[MIT](LICENCE.md)

[version]: https://img.shields.io/github/tag/halostatue/fish-macos.svg?label=Version
[fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
