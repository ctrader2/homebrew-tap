class Platoon < Formula
  desc "A terminal app for running and managing Claude Code and Codex sessions: every conversation in one list, projects with notes, tasks run by squads"
  homepage "https://github.com/ctrader2/platoon"
  version "1.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.2/platoon-tui-aarch64-apple-darwin.tar.xz"
      sha256 "3f17440fdf2f131451af3e51f87124ebfdc6e145a4a49462cc29c9d0b7475e43"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.2/platoon-tui-x86_64-apple-darwin.tar.xz"
      sha256 "c8d64219c327020ce60c666bbe8e3ea6c2da13d35a6823e61c9dbd2c6a222b7f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.2/platoon-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "7cd65fc5f2ba8627464f33446c818017219227a3a266b464a7c167a1856d240f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.2/platoon-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "bbeddb8b27d6e01c4ae84cc1d9e8c44de447b28a90dd633dce8d3763f5af7b8a"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "platoon"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "platoon"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "platoon"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "platoon"
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
