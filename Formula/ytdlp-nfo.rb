class YtdlpNfo < Formula
  include Language::Python::Virtualenv

  desc "Download videos with NFO metadata files for Jellyfin/Kodi"
  homepage "https://github.com/LNA-DEV/ytdlp-nfo"
  url "https://github.com/LNA-DEV/ytdlp-nfo/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "0055c3b651ec36b5086f836d2a54625733d688a3863cce6dd5002292008cb6b2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "python@3.12"

  def install
    # Create virtualenv and install the main package
    venv = virtualenv_create(libexec, "python3.12")
    # Install yt-dlp using the system pip (gets latest version)
    venv.pip_install "yt-dlp"
    # Install the ytdlp-nfo package
    venv.pip_install buildpath
    # Create symlink to make command available
    bin.install_symlink libexec/"bin/ytdlp-nfo"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/ytdlp-nfo 2>&1", 1)
    # Test that yt-dlp is available and working
    system libexec/"bin/python", "-c", "import yt_dlp; print(yt_dlp.version.__version__)"
  end
end
