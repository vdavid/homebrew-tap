class Smb2 < Formula
  desc "Command-line SMB2/3 client: list, stat, move, and delete files on a share without mounting it"
  homepage "https://github.com/vdavid/smb2"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.5.2/smb2-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1be8ba2a687c70f22e5ebb78f0a2fa8e21aa200eae39122f27a3f548518e0c66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.5.2/smb2-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1d92b4e6acfb0d9443e706908dc9fb946ec16d831bf34eed4e415d63200c6e5a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.5.2/smb2-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "476ca565e0d3ac6e29a3863ab9608ea109021903b5e590cfdd4d1cd93f4f063a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.5.2/smb2-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7170d0c8b1603488738167dfa79722cc1aad0137304d8bf0a14f590191df4a09"
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
