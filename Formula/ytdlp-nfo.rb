class YtdlpNfo < Formula
  include Language::Python::Virtualenv

  desc "Download videos with NFO metadata files for Jellyfin/Kodi"
  homepage "https://github.com/LNA-DEV/ytdlp-nfo"
  url "https://github.com/LNA-DEV/ytdlp-nfo/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "fe6f6880c0795ec30f5c5fa1bfe6d91ee83b31f928503f661801c4686e8cebac"
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
