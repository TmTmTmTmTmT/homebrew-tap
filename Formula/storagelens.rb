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
      If the app was built with an ad-hoc signature, you have to allow it
      again after every update.
    EOS
  end

  test do
    assert_path_exists prefix/"StorageLens.app/Contents/MacOS/StorageLens"
    system "codesign", "--verify", "--strict", prefix/"StorageLens.app"
  end
end
