# homebrew-tap

Homebrew tap for `kavilo`.

## Install

```bash
brew tap rdu16625/tap
brew install rdu16625/tap/kavilo
```

## Run at Login

After you finish `kavilo onboard` and update `~/.kavilo/config.json`, you can
keep the runtime running in the background with:

```bash
brew services start kavilo
```

Stop it with:

```bash
brew services stop kavilo
```

On macOS, screen capture is still usually more reliable when `kavilo` is run
from Terminal or iTerm because Screen Recording permission is tied to GUI apps.

## Upgrade

```bash
brew update
brew upgrade kavilo
```
