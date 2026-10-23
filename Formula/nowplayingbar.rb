class Nowplayingbar < Formula
  desc "macOS menu bar Now Playing widget with a Liquid Glass control card"
  homepage "https://github.com/TmTmTmTmTmT/NowPlayingBar"
  url "https://github.com/TmTmTmTmTmT/NowPlayingBar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "1c7229f80b8d888e5797c97ad65b77a407f52891997f37d461c945510d229622"
  license "MIT"

  depends_on macos: :tahoe

  def install
    ENV["SWIFT_BUILD_FLAGS"] = "--disable-sandbox"
    system "./build-app.sh"
    prefix.install "build/NowPlayingBar.app"
  end

  def caveats
    <<~EOS
      Start the widget with:
        open #{opt_prefix}/NowPlayingBar.app
      To keep it in /Applications:
        cp -R #{opt_prefix}/NowPlayingBar.app /Applications/
      Showing shuffle/repeat state for Apple Music asks for Automation
      permission the first time.
    EOS
  end

  test do
    assert_predicate prefix/"NowPlayingBar.app/Contents/MacOS/NowPlayingBar", :exist?
    system "codesign", "--verify", "--deep", prefix/"NowPlayingBar.app"
  end
end
