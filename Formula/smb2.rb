class Smb2 < Formula
  desc "Command-line SMB2/3 client: list, stat, move, and delete files on a share without mounting it"
  homepage "https://github.com/vdavid/smb2"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.6.0/smb2-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d5b5d182d840a7f57f970bde162ded824fc1651e46f46c8b5ccbbb45a96c6b85"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.6.0/smb2-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d123815a9f59b111c46ff97ed9f1211986a5cc1c8ed58147803ecdd47a648547"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.6.0/smb2-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea84ccaae65740d7a296ee86d856e614a19647717daa43851936ba4d1d1461a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/smb2/releases/download/smb2-cli-v0.6.0/smb2-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a6ac3c50ccc989092fce8e8aa95690b19811c743f82e2697c37d2ffb5b3b4dd"
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
