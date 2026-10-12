# homebrew-tap

Personal Homebrew tap.

```
brew tap serubin/tap
```

| Formula | |
|---|---|
| `deja` | Predictive inline shell autosuggestions for zsh, built from the `canary` branch |
| `wallspan` | The wallspan CLI on its own |
| `teams-spotify-sync` | Auto-adjust Spotify volume during Microsoft Teams meetings |

| Cask | |
|---|---|
| `wallspan` | Wallspan.app, the menu bar app, which bundles the CLI |
| `wallspan@beta` | The same app, following betas and release candidates |

```
brew install serubin/tap/deja
brew install --cask serubin/tap/wallspan
```

The wallspan casks and formula are alternatives, not companions — all three claim `wallspan`
on your PATH, so install one of them. Wallspan 0.1.0 is ad-hoc signed rather than
notarised, so macOS blocks its first launch until you allow the app under System Settings >
Privacy & Security. Later releases and betas are notarised.

`wallspan@beta` moves to each new beta, and to each stable release newer than its latest
beta. To switch tracks, uninstall one cask and install the other, then turn **Cycle in the
Background** back on, since uninstalling removes the LaunchAgent:

```
brew uninstall --cask wallspan
brew install --cask serubin/tap/wallspan@beta
```

`deja` shares a name with the upstream `giammarco-ferranti/deja/deja`, so use the
fully-qualified name if you have both taps.

Formerly `serubin/tools`, then briefly `serubin/formula`. GitHub redirects both old
repository names here, so an existing tap keeps fetching, but re-tap to get the name right:

```
brew untap serubin/tools serubin/formula
brew tap serubin/tap
```
