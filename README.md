# halostatue/fish-brew

Configuration and utilities for [Homebrew](https://brew.sh) in the
<a href="https://fishshell.com" title="friendly interactive shell">fish
shell</a>.

[![Versin](https://img.shields.io/github/tag/halostatue/fish-brew.svg?label=Version)](https://github.com/halostatue/fish-utils/releases)

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher) (recommended):

```fish
fisher add halostatue/fish-brew
```

<details>
<summary>Not using a package manager?</summary>

---

Copy `functions/*.fish` and `conf.d/*.fish` to your fish configuration
directory preserving the directory structure.
</details>

### System Requirements

- [fish](https://github.com/fish-shell/fish-shell) 3.0+

## Startup Configuration (conf.d)

Adds Homebrew paths to the Fish shell paths. This uses `path:unique` from
[halostatue/fish-utils](https://github.com/halostatue/fish-utils) to manage
`$PATH` and `$MANPATH`.

If Homebrew is installed into `~/.brew` (my preferred installation location
for Homebrew), this will be detected.

## Functions

### brew-prefix

```fish
brew-prefix
brew-prefix openssl
```

An enhanced wrapper around `brew --prefix`.

### has:keg

```fish
has:keg openssl
```

Returns true if the named keg is installed.

### with:keg:openssl

```fish
with:keg:openssl make
```

Since the OpenSSL keg is not linked and some

## License

[MIT](LICENCE.md)
