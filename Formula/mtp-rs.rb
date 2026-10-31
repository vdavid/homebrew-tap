class MtpRs < Formula
  desc "Universal MTP file transfer CLI built on mtp-rs"
  homepage "https://github.com/vdavid/mtp-rs"
  version "0.11.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.5/mtp-rs-cli-aarch64-apple-darwin.tar.xz"
      sha256 "58ee71bd0cef15a6558d951609a2262dbb6ebda20381eefd4c1c4b7d31bcf98a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.5/mtp-rs-cli-x86_64-apple-darwin.tar.xz"
      sha256 "371a806ab3fbcbd4c5c60f4c8b910e704a408636005213ae0087b2e713e1c1cc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.5/mtp-rs-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7a4c667c99be3b6e0c35a44c35d9a1b8b456b02e2fd3e843398388dd6788e476"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.5/mtp-rs-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "509a48ffe56c90c85ca63fa58cf50d2934f4c5be522b382f94bc944d800ee79c"
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
