class Smb2 < Formula
  desc "Command-line SMB2/3 client: list, stat, move, and delete files on a share without mounting it"
  homepage "https://github.com/vdavid/smb2"
  version "0.4.16"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.16/smb2-cli-aarch64-apple-darwin.tar.xz"
      sha256 "75c8fc5b0cbe936434a583e7b2b5a9b005ab5e511e19626e342e38655a940851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.16/smb2-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d0b7e9e72c2ef9f7ae4bc54e919d49663d3682649d6099a6621e2ef47f068433"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.16/smb2-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5793147b1f55869bd8856ef4f7b552e42edc0dd903c1cfaec3473ba0b5c37f30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.4.16/smb2-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a9b1b26001f5cc392615ba1a75eb4f179b3dd660887d9bea46f42e51331c92b7"
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
