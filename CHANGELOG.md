# fish-macos Changelog

## 6.1.0 / 2025-01-15

- Added `mac brightness` to change the screen brightness. Adapted from
  [mattmc3/macos.fish/functions/bright.fish][bright].

- Rewrote `mac touchid sudo` encompassing a number of changes.

  - MacPorts-installed `pam_reattach` is no longer supported and will not be
    located. If it is present (even if manually added), then
    `mac touchid sudo on` **will** remove it. A warning about this will always
    be printed, even if `--quiet` is specified.

  - If `pam_reattach` is not configured with the currently discovered
    `pam_reattach`, a message will be printed (even if `--quiet` is specified)
    and the existing `pam_reattach` configuration will be removed.

  - Recent versions of macOS support a file `/etc/pam.d/sudo_local` that is kept
    during operating system upgrades so that Touch ID support should continue to
    work.

    If a migration from `/etc/pam.d/sudo` to `/etc/pam.d/sudo_local` is
    detected, a message will be printed, even if `--quiet` is specified.

## 6.0.1 / 2025-01-04

- Added version information to comment tags.
- Switched to long flags where possible.
- Switched to `set --function` instead of `set --local`.
- Updated documentation.
- Added tooling to the Justfile for easier release management.

## 6.0.0 / 2024-12-30

- Removed `has:app`.

- Updated Code of Conduct to Contributor Covenant 2.1.

- Tags will no longer have `.x` attached.

## 5.1.2 / 2023-02-26

- Fixed an error where MacPorts-installed `pam_reattach` was not being detected.

- Added a warning on installing `pam_reattach` with MacPorts and that `sudo`
  support must be disabled _before_ uninstalling `pam_reattach`. The
  installation of `pam_reattach` with MacPorts is _discouraged_ for this reason,
  but still supported. A warning will _always_ be printed when using MacPorts,
  even if `--quiet` is specified.

## 5.1.1 / 2023-02-21

- Changed internal use of `has:app` to `has_app`.

## 5.1 / 2023-02-19

- Deprecated `has:app` and replaced with `has_app`.

- Added `mac touchid` to control Touch ID support for `sudo`.

## 5.0 / 2022-12-05

- Changed `manp` to be compatible with macOS Ventura and prefer not using an
  external package (Ghostscript). The solution was adapted from
  [man2pdf.sh][man2pdf.sh] by [Pico Mitchell][Pico Mitchell], originally found
  via Rob Griffiths’s [blog][blog] and Armin Briegel's
  [Scripting OS X][Scripting OS X].

- Added `app frontmost` to show the app with the current top window.

- Removed features no longer supported under macOS Ventura:

  - `mac airport history` (the matching plist is empty)

  - `mac lock-screen` (the underlying binary is missing)

- Removed `trash`. There are better tools than this function, such as:

  - [trash][trash], a small command-line program that moves files or folders to
    the trash.

  - [rmtrash][rmtrash] is a small utility that will move the file to OS X's
    Trash rather than obliterating the file (as rm does).

  - [macos-trash][macos-trash] is a small command-line program that moves files
    or folders to the trash, written in Swift

- Improved completion scripts and overall consistency.

- Added several governance documents, adopting a code of conduct.

## 4.0 / 2022-06-11

- Extracted the various sub-functions only loaded when `app` is run (and `mac`
  and `finder`) so that they can be called more reliably. This is now much
  better and fixes a bug with `has:app` where applications installed in
  /System/Applications (new with macOS 11 and later) were not found.

- Remove the function `pdfmerge`. This has been turned into a script that will
  work both on macOS and on any system with Ghostscript installed. It will be
  published later.

- Fixed the `remind` function so that it will fail if the Reminders app is not
  installed _or_ the provided text is empty.

- Fixed the `note` function so that it will fail if the Notes app is not
  installed _or_ the provided text is empty.

- Added `mac version` command to show the current macOS version in one of
  several different ways. This depends on halostatue/fish-utils-core@v2.1 or
  higher.

## 3.0 / 2022-04-02

- Rewrote the `app` function to more consistently use `app find` for the other
  subcommands. `app find` is more robust and does not depend on glob matching.
  Alternative spellings of `app bundleid` are no longer accepted. Various flags
  have been changed, added, or removed:

  - All subcommands support `--help`
  - All subcommands support `--exact`, which is forwarded to `app find`, which
    makes the pattern match stricter, but is not incompatible with `--all`.
  - `app find` no longer accepts `--any`; the short form for `--all` is now
    `-a`, not `-A`.
  - The `app quit` short form for `--restart` is now `-r`, not `-R`.

- Fixed the remind function definition.

- Updated the `mac` app to remove some subcommand or argument aliases.

  - `mac airdrop` no longer supports `up` and `down`, but only `on` and `off`

- Added completion wrappers for `manp` and `ql`.

- Improved the uninstall function.

## 2.0 / 2020-06-28

- Added `app` function. Adds new functionality and replaces `quitapp`.
- Added `mac` function. Replaces `airdrop` (`mac airdrop`), `airport`
  (`mac airport`), `flushdns` (`mac flushdns`), `lock-screen`
  (`mac lock-screen`), `lsclean` (`mac lsclean`), and `vol` (`mac vol`).

- Moved `quarantine` to `finder quarantine`.
- Moved `desktop-icons` to `finder desktop-icons`.
- Removed `finder show-hidden` and `finder hide-hidden`.
- Removed `plistbuddy`. Prefer using `plutil`.
- Removed `dash`; this exists in `halostatue/fish-macos-apps` instead.
- Removed `battery`. Use either `halostatue/fish-battery` or
  `oh-my-fish/plugin-battery` instead.
- Removed aliases to `finder` subcommands.

## 1.2 / 2019-12-31

- Added `airdrop`, `trash`, and several aliases to subcommands for `finder`
  (matching [oh-my-fish/plugin-osx][oh-my-fish/plugin-osx]).

- Improved some `finder` subcommands.

- Fixed a bug in `has:app` and the uninstaller.

## 1.1 / 2019-06-17

- Improved several utilities and added an uninstaller.

## 1.0 / 2019-06-16

- Initial version

[blog]: https://robservatory.com/open-postscript-files-in-preview-in-macos-ventura/
[macos-trash]: https://github.com/sindresorhus/macos-trash
[man2pdf.sh]: https://gist.github.com/PicoMitchell/619c12fd6a53ae6ec657514915d4edf9
[oh-my-fish/plugin-osx]: https://github.com/oh-my-fish/plugin-osx
[pico mitchell]: https://github.com/PicoMitchell
[rmtrash]: http://www.nightproductions.net/cli.htm
[scripting os x]: https://scriptingosx.com/2022/11/on-viewing-man-pages-ventura-update/
[trash]: https://github.com/ali-rantakari/trash
[bright]: https://github.com/mattmc3/macos.fish/blob/main/functions/bright.fish
