# frozen_string_literal: true

cask "wallspan@beta" do
  version "1.0.0-beta.2"
  sha256 "16cb65033d3ad248bee13513baaacf47997d354646fff1c9cc745632281e95b3"

  url "https://github.com/Serubin/WallSpan/releases/download/v#{version}/Wallspan-#{version}.zip"
  name "Wallspan"
  desc "Menu bar app for spanning one wallpaper across every display (beta)"
  homepage "https://github.com/Serubin/WallSpan"

  # Both casks install the same app and link the same `wallspan`. The formula clash can't be
  # declared, since a cask's conflicts_with takes only :cask, so the caveats carry it.
  conflicts_with cask: "wallspan"
  # Package.swift pins .macOS(.v14).
  depends_on macos: :sonoma

  app "Wallspan.app"
  # The app bundles the CLI and prefers whichever `wallspan` is on PATH, so linking its own
  # copy is what keeps the two from drifting to different builds.
  binary "#{appdir}/Wallspan.app/Contents/Helpers/wallspan"

  uninstall launchctl: "net.serubin.wallspan",
            quit:      "net.serubin.wallspan.app"

  zap trash: [
    "~/Library/Application Support/wallspan",
    "~/Library/LaunchAgents/net.serubin.wallspan.plist",
    "~/Library/Logs/wallspan.log",
    "~/Library/Preferences/net.serubin.wallspan.app.plist",
  ]

  caveats do
    paragraphs = [<<~EOS]
      This cask follows Wallspan betas and release candidates, and moves to each stable
      release that is newer than the latest beta.
    EOS
    # Only 0.1.0 predates Developer ID signing and notarisation.
    if version == "0.1.0"
      paragraphs << <<~EOS
        No beta has shipped yet, so this installs 0.1.0, which is ad-hoc signed and not
        notarised. macOS blocks its first launch: open the app once, then allow it under
        System Settings > Privacy & Security.
      EOS
    end
    paragraphs << <<~EOS
      It cannot be installed alongside the wallspan cask or the wallspan formula. To come
      back from the beta track:

        brew uninstall --cask wallspan@beta
        brew install --cask serubin/tap/wallspan

      Switching casks removes the LaunchAgent, so turn Cycle in the Background back on
      afterwards. Settings are kept.
    EOS
    paragraphs.join("\n")
  end
end
