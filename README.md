# halostatue/fish-macos

Useful functions for MacOS using [fish shell][].

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

### finder

Links a Finder window with the current shell. Supports the following
subcommands:

- `track`: Turn on Finder/path tracking. The frontmost Finder window will be
  updated when the current path changes in the current shell.
- `untrack`: Turn off Finder/path tracking.
- `list`, `icon`, `column`: Change the frontmost Finder window to the listed
  view.
- `pwd`: Print the current path of the frontmost Finder window.
- `cd`: Changes the current path to that of the frontmost Finder window.
- `clean`: Cleans the current path and subdirectories of `.DS_Store` files.
- `show-hidden`: Shows hidden files in Finder.
- `hide-hidden`: Hides hidden files in Finder.
- `selected`: Prints a list of selected folders and files from Finder.

### flushdns

Flush the MacOS DNS cache.

### has:app

Returns true if the named MacOS application exists.

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

### vol

Set or show the Mac audio volume.

## License

[MIT](LICENCE.md)

[Version]: https://img.shields.io/github/tag/halostatue/fish-macos.svg?label=Version
[![Version][]]: https://github.com/halostatue/fish-macos/releases
[Fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
