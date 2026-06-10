# Cmdr Homebrew tap

A personal Homebrew tap for [Cmdr](https://getcmdr.com), a fast, keyboard-driven dual-pane file manager for macOS.

## Help bring Cmdr to the main Homebrew cask

Cmdr got rejected from the official [homebrew-cask](https://github.com/Homebrew/homebrew-cask) repo. Not because of the
app, but because the [vdavid/cmdr](https://github.com/vdavid/cmdr) repo doesn't meet Homebrew's notability bar yet.
Self-submitted casks need the source repo to have at least 90 forks, 90 watchers, or 225 stars, and Cmdr isn't there.
You can see the rejected submission here: [homebrew-cask PR #268854](https://github.com/Homebrew/homebrew-cask/pull/268854).

If you want a clean `brew install cmdr` with no tap, you can now help with three clicks. Head to
[github.com/vdavid/cmdr](https://github.com/vdavid/cmdr) and:

1. Star it.
2. Watch it.
3. Fork it.

That's it. Once the repo clears the bar, Cmdr can move into the main cask and this tap goes away. Thank you so much for
the boost.

## Install

```sh
brew tap vdavid/tap
brew install --cask cmdr
```

## Notes

- Cmdr updates itself. The cask sets `auto_updates true`, so `brew upgrade` leaves it alone unless you pass `--greedy`.
- The cask in this tap is bumped automatically on every Cmdr release, so it always points at the latest version.
- Requires macOS 12 Monterey or later.
- Free for personal use, paid for commercial use. See [getcmdr.com](https://getcmdr.com) for the details.
