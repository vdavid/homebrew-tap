class MtpRs < Formula
  desc "Universal MTP file transfer CLI built on mtp-rs"
  homepage "https://github.com/vdavid/mtp-rs"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.9.1/mtp-rs-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2429dca838c046e89a8d32b1a3891ade2359464a7addd8b7ae0680be63aac22d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.9.1/mtp-rs-cli-x86_64-apple-darwin.tar.xz"
      sha256 "be0784455d2fca862f1761a3dc787250c42dd7ad864543ade80897b7ef777da1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.9.1/mtp-rs-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c6c3c0d3e4ae2bd78abfa5aa26c9ed579b43a0f982db4af6a4945aebd7730ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.9.1/mtp-rs-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cb22715f04b38ea503b8281363ae708158d3c9ae7771c411b2422ba65a29d405"
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
