# fish-macos Changelog

## 2.0

- Added `app` function. Adds new functionality and replaces `quitapp`.
- Added `mac` function. Replaces `airdrop` (`mac airdrop`), `airport`
  (`mac airport`), `flushdns` (`mac flushdns`), `lock-screen`
  (`mac lock-screen`), `lsclean` (`mac lsclean`), and `vol` (`mac vol`).

- Moved `quarantine` to `finder quarantine`.
- Moved `desktop-icons` to `finder desktop-icons`.
- Removed `finder show-hidden` and `finder hide-hidden`.
- Removed 'plistbuddy'.
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
