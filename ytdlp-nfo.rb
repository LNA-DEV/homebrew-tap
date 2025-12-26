class YtdlpNfo < Formula
  include Language::Python::Virtualenv

  desc "Download videos with NFO metadata files for Jellyfin/Kodi"
  homepage "https://github.com/LNA-DEV/ytdlp-nfo"
  url "https://github.com/LNA-DEV/ytdlp-nfo/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "b22a447524e6a93727ad9ab45f326ada72607a0a1773c4c1c70088d0fd0bfe27"
  license "MIT"
  revision 1

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
    # Install latest yt-dlp from PyPI (pip will handle yt-dlp's dependencies)
    system libexec/"bin/pip", "install", "yt-dlp"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ytdlp-nfo 2>&1", 1)
    # Test that yt-dlp is available and working
    system libexec/"bin/python", "-c", "import yt_dlp; print(yt_dlp.version.__version__)"
  end
end
