# frozen_string_literal: true

cask "wallspan" do
  version "0.1.0"
  sha256 "53886c52e2bb0df0d79bd2aa00c00f0cd49fb1bad67bfa4093c580e61e529edb"

  url "https://github.com/Serubin/WallSpan/releases/download/v#{version}/Wallspan-#{version}.zip"
  name "Wallspan"
  desc "Menu bar app for spanning one wallpaper across every display"
  homepage "https://github.com/Serubin/WallSpan"

  # Both casks install the same app and link the same `wallspan`. The formula clash can't be
  # declared, since a cask's conflicts_with takes only :cask, so the caveats carry it.
  conflicts_with cask: "wallspan@beta"
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
    paragraphs = []
    # Only 0.1.0 predates Developer ID signing and notarisation.
    if version == "0.1.0"
      paragraphs << <<~EOS
        Wallspan 0.1.0 is ad-hoc signed and not notarised, so macOS blocks its first
        launch: open the app once, then allow it under System Settings > Privacy & Security.
      EOS
    end
    paragraphs << <<~EOS
      This links the bundled CLI onto your PATH, so it cannot be installed alongside the
      wallspan formula or the wallspan@beta cask. Use one of them.
    EOS
    paragraphs.join("\n")
  end
end
