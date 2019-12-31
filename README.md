# halostatue/fish-macos

Useful functions for macOS using [fish shell][].

[![Version][]][]

## Installation

Install with [Fisher][] (recommended):

```fish
fisher add halostatue/fish-macos
```

<details>
<summary>Not using a package manager?</summary>

---

Copy `functions/*.fish` to your fish configuration directory preserving the
directory structure.
</details>

### System Requirements

- [fish][] 3.0+

## Functions

### airdrop

Works with the Mac AirDrop configurations. Has the following subcommands:

- `on`: Turns AirDrop on.
- `off`: Turns AirDrop off.
- `status`: Reports the status of AirDrop.

### airport

Work with Mac AirPort configurations. Has the following subcommands:

- `scan`: Scans the current AirPort configurations.
- `ssid`: Prints the current AirPort network SSID.
- `history`: Prints the history of network connections.
- `on`: Turns AirPort `on`.
- `off`: Turns AirPort `off`.
- `password`: Recovers the current AirPort network password, or the password for
  a specified SSID.

### battery

Report on battery status.

Reports time remaining by default; use `battery percent` or `battery %` to
present the percentage of battery remaining.

### dash

Look up documentation in Dash.app.

### desktop-icons

Manage the visibility of desktop icons. Has the following subcommands:

- `hide`, `off`: Hides desktop icons.
- `show`, `on`: Displays desktop icons.
- `toggle`: Hides the desktop icons if currently visible, shows them otherwise.
- `status`: Shows the current desktop icon visibility.

### finder (cdf, pfd, pfs, pushdf)

Links a Finder window with the current shell. Supports the following
subcommands:

- `track`: Turn on Finder/path tracking. The frontmost Finder window will be
  updated when the current path changes in the current shell.
- `untrack`: Turn off Finder/path tracking.
- `list`, `icon`, `column`: Change the frontmost Finder window to the listed
  view.
- `pwd`: Print the current path of the frontmost Finder window. Accepts an
  integer parameter specifying the Finder window depth to use (the frontmost
  window is `1`). Also available as command `pfd`.
- `cd`: Changes the current path to that of the frontmost Finder window.
  Accepts an integer parameter specifying the finder window depth to use (the
  frontmost window is `1`). Also available as command `cdf`.
- `cd`: Changes the current path with pushd to that of the frontmost Finder
  window. Accepts an integer parameter specifying the finder window depth to
  use (the frontmost window is `1`). Also available as command `pushdf`.
- `clean`: Cleans the current path and subdirectories of `.DS_Store` files.
- `hidden`: Shows or hides hidden files in Finder. Accepts a parameter
  `yes`/`true` or `no`/`false`. Also available as command `showhidden`.
- `show-hidden`: Shows hidden files in Finder. Deprecated. Use `hidden`
  instead.
- `hide-hidden`: Hides hidden files in Finder. Deprecated. Use `hidden`
  instead.
- `selected`: Prints a list of selected folders and files from Finder. Also
  available as command `pfs`.

### flushdns

Flush the MacOS DNS cache.

### has:app

Returns true if the named MacOS application exists. Searches in
`/Applications`, `~/Applications`, `/Applications/Setapp`, and
`/Applications/Xcode.app/Contents/Applications`.

### lock-screen

Locks the screen.

### lsclean

Clean LaunchServices to remove duplicate 'Open with...' entries.

### manp

View a manpage in Preview.app.

### note

Add a note to Notes.app.

### pdfmerge

Merge one or more PDFs.

### plistbuddy

A wrapper for PlistBuddy.

### ql

QuickLook a file from the command-line.

### quarantine

Show or clear quarantine events and attributes. Supports the following
subcommands:

- `show`: Shows quarantine events from quarantine databases.
- `clear`: Clears quarantine events from quarantine databases.
- `clean`: Cleans the named file(s) of quarantine extended attributes.

### quitapp

Quits one or more named MacOS applications.

### remind

Add a note to Reminders.app.

### trash

Move one or more files into the Trash.

### vol

Set or show the Mac audio volume.

## License

[MIT](LICENCE.md)

[Version]: https://img.shields.io/github/tag/halostatue/fish-macos.svg?label=Version
[![Version][]]: https://github.com/halostatue/fish-macos/releases
[Fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
