class Zunel < Formula
  desc "Rust CLI and gateway for the Zunel personal AI assistant."
  homepage "https://github.com/rdu16625/zunel"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rdu16625/zunel/releases/download/v0.2.0/zunel-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d6054112e8592f294c396c688ec590341b619c34feced040f27ec5fc62a83b47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rdu16625/zunel/releases/download/v0.2.0/zunel-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1b9e346291b499f32655945f6e040d8cf9b89aeb187f902800e0a43f2cdf86de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rdu16625/zunel/releases/download/v0.2.0/zunel-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "89dd543ddc69f18a9d7df8a82dc4e49198837cccb1f0e901217d127a8f151525"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rdu16625/zunel/releases/download/v0.2.0/zunel-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "de10b0976d7296a0333189c7a0cc7d38e3b51f491c2d0eb54be27d820d5ec9fe"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "zunel" if OS.mac? && Hardware::CPU.arm?
    bin.install "zunel" if OS.mac? && Hardware::CPU.intel?
    bin.install "zunel" if OS.linux? && Hardware::CPU.arm?
    bin.install "zunel" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
