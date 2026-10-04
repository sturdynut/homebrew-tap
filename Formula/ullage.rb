class Ullage < Formula
  desc "See how full your Claude Code and Codex context windows are, from the menu bar"
  homepage "https://github.com/sturdynut/Ullage"
  url "https://github.com/sturdynut/Ullage/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "9ac05a9cee37a27ddf65dc363e0658a6cbf85d9583110f4d482d8140f3b40a2e"
  # PolyForm Shield 1.0.0 (LICENSE.md), which Homebrew's SPDX list does not include.
  license :cannot_represent
  head "https://github.com/sturdynut/Ullage.git", branch: "main"

  depends_on xcode: ["16.0", :build]
  depends_on macos: :sonoma

  def install
    # Homebrew builds in its own sandbox, where SwiftPM's can't start.
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "ullage"
    bin.install ".build/release/ullage"

    ENV["ULLAGE_VERSION"] = version.to_s
    ENV["SWIFT_BUILD_FLAGS"] = "--disable-sandbox"
    system "scripts/bundle-app.sh", prefix
  end

  service do
    # The phone page. The menu bar app already ingests, so serve doesn't watch.
    run [opt_bin/"ullage", "serve", "--no-watch"]
    keep_alive true
    log_path var/"log/ullage-serve.log"
    error_log_path var/"log/ullage-serve.log"
  end

  def caveats
    <<~TEXT
      To put the app in Applications and open it:
        ln -sf "#{opt_prefix}/Ullage.app" /Applications/Ullage.app
        open /Applications/Ullage.app

      To serve the phone page in the background, now and at login:
        brew services start ullage
      It binds 127.0.0.1:7878 only. To reach it from your phone, put
      Tailscale in front of it: tailscale serve --bg 7878
    TEXT
  end

  test do
    assert_match "USAGE", shell_output("#{bin}/ullage help")
    db = testpath/"t.db"
    assert_match "rows", shell_output("#{bin}/ullage info --db #{db}")
    assert_path_exists prefix/"Ullage.app/Contents/MacOS/UllageApp"
  end
end
