class Smb2 < Formula
  desc "Command-line SMB2/3 client: list, stat, move, and delete files on a share without mounting it"
  homepage "https://github.com/vdavid/smb2"
  version "0.4.19"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.19/smb2-cli-aarch64-apple-darwin.tar.xz"
      sha256 "bd273169b3b853f16242c94ef73812c72bec8f9ade9c8ec0d79cc04fe0a353e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.19/smb2-cli-x86_64-apple-darwin.tar.xz"
      sha256 "671f8a9cf18d03df817741952c11a48ca1ec368a39c68b9ee8ef3100592891ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.19/smb2-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e5089169dc16d54b6d1e1bf47463be014ab6fa767d0eec665afac7ece598502"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.19/smb2-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f8d0870e56c9520a80e9dc9c6034a3c93ef34f25470558c29e16cfc5750c06f"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "smb2"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "smb2"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "smb2"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "smb2"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
