class MtpRs < Formula
  desc "Universal MTP file transfer CLI built on mtp-rs"
  homepage "https://github.com/vdavid/mtp-rs"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.10.0/mtp-rs-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6585184d41900b40f2baee38784bb5702f5f3caf9cf8a17f4908e91650471af0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.10.0/mtp-rs-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3e1c3f24d000abad342e5b349051979edd40d4525b8b76fac3c4ba1ed2ba0c1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.10.0/mtp-rs-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "082f991ee036e6ca5f57bfd64bda3e2b4017d737675042b00da8bdaa169cf329"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.10.0/mtp-rs-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "722a8de42d2468c23388dbb03f6ce4eefe462a1a416a80a4914d8901fac4b2b9"
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
      bin.install "mtp-rs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mtp-rs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mtp-rs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mtp-rs"
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
