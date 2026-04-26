class Kavilo < Formula
  desc "A lightweight personal AI assistant — single binary, zero dependencies"
  homepage "https://github.com/rdu16625/kavilo"
  version "2.0.0-alpha.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/rdu16625/homebrew-tap/releases/download/v2.0.0-alpha.1/kavilo_darwin_arm64.zip"
      sha256 "98a0e4d29be1400f3eecb3c5a0e63c4cf47a6823b5e2934bea7a63e9dd837b88"
    else
      url "https://github.com/rdu16625/homebrew-tap/releases/download/v2.0.0-alpha.1/kavilo_darwin_amd64.zip"
      sha256 "f6f0e1d83b8785cfc8cb0bc7ab9b5ebd3746d11b569f3d90651fe714d8112f18"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/rdu16625/homebrew-tap/releases/download/v2.0.0-alpha.1/kavilo_linux_arm64.tar.gz"
      sha256 "df83b096043ffe68339ef57dba838a7367b9b53d80c6ffe9579194bd0ea45e5c"
    else
      url "https://github.com/rdu16625/homebrew-tap/releases/download/v2.0.0-alpha.1/kavilo_linux_amd64.tar.gz"
      sha256 "21a2365441c1e6da1729364aa13102b732aef3472b47e16375535487b835e109"
    end
  end

  def install
    bin.install "kavilo"
  end

  service do
    run [opt_bin/"kavilo", "start"]
    keep_alive true
    environment_variables PATH: std_service_path_env
    log_path var/"log/kavilo.log"
    error_log_path var/"log/kavilo.err.log"
  end

  def caveats
    <<~CAVEATS
      To run kavilo in the background and restart it at login:
        brew services start kavilo

      To stop it:
        brew services stop kavilo

      On macOS, screen capture is usually more reliable when kavilo is launched
      from a GUI terminal app that already has Screen Recording permission.
    CAVEATS
  end

  test do
    system "#{bin}/kavilo", "version"
  end
end
