class Smb2 < Formula
  desc "Command-line SMB2/3 client: list, stat, move, and delete files on a share without mounting it"
  homepage "https://github.com/vdavid/smb2"
  version "0.4.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.17/smb2-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e9cbf064e2d26a6ae7742f885c8e6061daf215664eb6e48cd629741dc2ff0f94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.17/smb2-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4e1c7b27500694c79e5f821307283a9b886fb71e40f57db157051b4af6917761"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.17/smb2-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5633283936f4827c0dd3b4e596c93b7237663772150edc3aebf06ab8b32cc0ef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.17/smb2-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95c0d0301f704d784d28aa288a694ef98dcfdb4a0c2481aab2f1b0d2c0adbc68"
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
