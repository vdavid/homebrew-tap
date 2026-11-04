class MtpRs < Formula
  desc "Universal MTP file transfer CLI built on mtp-rs"
  homepage "https://github.com/vdavid/mtp-rs"
  version "0.11.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.7/mtp-rs-cli-aarch64-apple-darwin.tar.xz"
      sha256 "339c4ba6430d15506758a2d6649dc9caf7bef722b397e8cdaf1cba925e3c6399"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.7/mtp-rs-cli-x86_64-apple-darwin.tar.xz"
      sha256 "833bddb1850901d2100d84cfc0bac6d9f3227a4fad164de0309cff8a66bfbf59"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.7/mtp-rs-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f05aa3ae96d7e0175abb362d19e88e1121120a25a6d057a8ea6ba69014c7d940"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.7/mtp-rs-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c4bb0aac0c7cd1acf47f51a6a3d2fd4c6d0f0d1166e4e0a4470dea36f9027a9"
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
