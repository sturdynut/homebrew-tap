# sturdynut/tap

Homebrew formulae by [sturdynut](https://github.com/sturdynut).

## Ullage

See how full your coding agents' context windows are, from the macOS
menu bar. [Project page](https://github.com/sturdynut/Ullage).

```bash
brew install sturdynut/tap/ullage
ln -sf "$(brew --prefix)/opt/ullage/Ullage.app" /Applications/Ullage.app
open /Applications/Ullage.app
```

Homebrew builds it from source on your Mac (macOS 14+, Xcode 16+), so there's
no Gatekeeper warning. To serve the phone page in the background:

```bash
brew services start ullage
```

Ullage is licensed under the [PolyForm Shield License 1.0.0](https://github.com/sturdynut/Ullage/blob/main/LICENSE.md).
