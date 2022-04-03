# fish-macos Changelog

## 3.0

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

## 2.0

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

## 1.2

- Added `airdrop`, `trash`, and several aliases to subcommands for `finder`
  (matching [oh-my-fish/plugin-osx][]).

- Improved some `finder` subcommands.

- Fixed a bug in `has:app` and the uninstaller.

## 1.1

- Improved several utilities and added an uninstaller.

## 1.0

- Initial version

[oh-my-fish/plugin-osx]: https://github.com/oh-my-fish/plugin-osx
