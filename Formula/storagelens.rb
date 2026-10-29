class Storagelens < Formula
  desc "macOS storage map with per-folder app attribution and safe cleanup"
  homepage "https://github.com/TmTmTmTmTmT/StorageLens"
  url "https://github.com/TmTmTmTmTmT/StorageLens/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "4065dc1de39187c06b00db433c6436bb23ed51ea0bd4ca34d485449e73c648e1"

  depends_on macos: :tahoe

  def install
    ENV["SWIFT_BUILD_FLAGS"] = "--disable-sandbox"
    system "./build-app.sh"
    prefix.install "build/StorageLens.app"
  end

  def caveats
    <<~EOS
      Start the app with:
        open #{opt_prefix}/StorageLens.app
      To keep it in /Applications:
        cp -R #{opt_prefix}/StorageLens.app /Applications/
      Scanning protected folders needs Full Disk Access. Allow it in
      System Settings > Privacy & Security > Full Disk Access.
      Homebrew builds in a sandbox without keychain access, so the app is
      ad-hoc signed. If you have an Apple Development certificate, re-sign it
      after every install or upgrade so Full Disk Access stays granted:
        codesign --force --options runtime --sign "Apple Development" #{opt_prefix}/StorageLens.app
      Without re-signing, allow Full Disk Access again after each upgrade.
    EOS
  end

  test do
    assert_path_exists prefix/"StorageLens.app/Contents/MacOS/StorageLens"
    system "codesign", "--verify", "--strict", prefix/"StorageLens.app"
  end
end
