cask "cmdr" do
  version "0.25.0"
  sha256 "9b206c21596182a9008055ab0d98790da69c0f816225dba957ba358d50d1a45b"

  url "https://license.getcmdr.com/download/#{version}/universal"
  name "Cmdr"
  desc "Keyboard-driven dual-pane file manager"
  homepage "https://getcmdr.com/"

  livecheck do
    url "https://getcmdr.com/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  auto_updates true
  depends_on macos: :monterey

  app "Cmdr.app"

  zap trash: [
    "~/Library/Application Support/com.veszelovszki.cmdr",
    "~/Library/Caches/com.veszelovszki.cmdr",
    "~/Library/Logs/com.veszelovszki.cmdr",
    "~/Library/Preferences/com.veszelovszki.cmdr.plist",
    "~/Library/Saved Application State/com.veszelovszki.cmdr.savedState",
    "~/Library/WebKit/com.veszelovszki.cmdr",
  ]
end
