# halostatue/fish-macos

Useful functions for macOS using [fish shell][fish].

[![Version][version]](https://github.com/halostatue/fish-macos/releases)

## Installation

Install with [Fisher][fisher] (recommended):

```fish
# Fisher 3.x
fisher add halostatue/fish-macos@v3.x

# Fisher 4.0+
fisher install halostatue/fish-macos@v3.x
```

<details>
<summary>Not using a package manager?</summary>

---

Copy `functions/*.fish` to your fish configuration directory preserving the
directory structure.

</details>

### System Requirements

- [fish][fish] 3.0+

## Functions

### app

Utilities for working with MacOS apps. Has the following subcommands:

- `bundle`: Get the bundle ID for the application.
- `find`: Finds the full application path.
- `icon`: Obtains the application icon as a PNG.
- `quit`: Quits the named application.

### finder

Operates with the Finder from the current shell.

#### finder track

Turn on Finder/path tracking. The frontmost Finder window will be updated
when the current path changes in the current shell.

#### finder untrack

Turn off Finder/path tracking.

#### finder pwd

Print the current path of the frontmost Finder window. Accepts an integer
parameter specifying the Finder window depth to use (the frontmost window is
`1`).

#### finder cd

Changes the current path to that of the frontmost Finder window.
Accepts an integer parameter specifying the finder window depth to use (the
frontmost window is `1`).

#### finder pushd

Changes the current path with pushd to that of the frontmost
Finder window. Accepts an integer parameter specifying the finder window
depth to use (the frontmost window is `1`).

#### finder {update, list, icon, column}

Changes the Finder window to PWD. If `list`, `icon`, or `column` are used,
uses the list, icon, or column view.

#### finder clean

Cleans the specified path and subdirectories of `.DS_Store` files.

#### finder hidden

Shows or hides hidden files in Finder. Accepts a parameter `on` (show the
files), `off` (hide the files), or `toggle`. If no parameter is given,
shows the current state.

#### finder selected

Prints a list of selected folders and files from Finder. Also
available as command `pfs`.

#### finder quarantine

Show or clear quarantine events and attributes. Supports the following
subcommands:

- `show`: Shows quarantine events from quarantine databases.
- `clear`: Clears quarantine events from quarantine databases.
- `clean`: Cleans the named file(s) of quarantine extended attributes.

#### finder desktop-icons

Shows or hides the desktop icons. Accepts a parameter `on` (show the
files), `off` (hide the files), or `toggle`. If no parameter is given,
shows the current state.

### has:app

Returns true if one or more of the named MacOS application exists. This is a
specialized wrapper around `app find`.

### mac

Manage various aspects of the modern MacOS interface.

#### mac airdrop

Works with the Mac AirDrop configurations. Has the following subcommands:

- `on`: Turns AirDrop on.
- `off`: Turns AirDrop off.
- `status`: Reports the status of AirDrop.

#### mac airport

Work with Mac AirPort configurations. Has the following subcommands:

- `scan`: Scans the current AirPort configurations.
- `ssid`: Prints the current AirPort network SSID.
- `history`: Prints the history of network connections.
- `on`: Turns AirPort `on`.
- `off`: Turns AirPort `off`.
- `password`: Recovers the current AirPort network password, or the password for
  a specified SSID.

#### mac flushdns

Flush the MacOS DNS cache.

#### mac lock-screen

Locks the screen.

#### mac lsclean

Clean LaunchServices to remove duplicate 'Open with...' entries.

#### mac vol

Set or show the Mac audio volume.

### manp

View a manpage in Preview.app.

### note

Add a note to Notes.app.

### pdfmerge

Merge one or more PDFs.

### ql

QuickLook a file from the command-line.

### remind

Add a note to Reminders.app.

### trash

Move one or more files into the Trash.

## Licence

[MIT](LICENCE.md)

[version]: https://img.shields.io/github/tag/halostatue/fish-macos.svg?label=Version
[fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
