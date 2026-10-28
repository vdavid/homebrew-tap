class MtpRs < Formula
  desc "Universal MTP file transfer CLI built on mtp-rs"
  homepage "https://github.com/vdavid/mtp-rs"
  version "0.11.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.1/mtp-rs-cli-aarch64-apple-darwin.tar.xz"
      sha256 "4a01792403b3cd060173afa8c6dd94ebf90038a79540fb8a9da5a7713cc1dd4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.1/mtp-rs-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fd65f012edcba7c12eb48c69d030c8cb428426b2a4dc7ca4da38eaa177a6b2f4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.1/mtp-rs-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cef7c35262380119eb1eced79d690a1679a6146dd7da7795d0c9b752f4014126"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vdavid/mtp-rs/releases/download/mtp-rs-cli-v0.11.1/mtp-rs-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac732be53c3bd674ab50302dc07d0f3dedec5900b2d5d3098e9d0599abc99f07"
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
