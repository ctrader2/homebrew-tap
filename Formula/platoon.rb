class Platoon < Formula
  desc "A terminal app for running and managing Claude Code and Codex sessions: every conversation in one list, projects with notes, tasks run by squads"
  homepage "https://github.com/ctrader2/platoon"
  version "1.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.0/platoon-tui-aarch64-apple-darwin.tar.xz"
      sha256 "c67220454852b48a576a0aed7e3abe7982c3e894117b3d8af698198970595ecc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.0/platoon-tui-x86_64-apple-darwin.tar.xz"
      sha256 "2fa05ea972da187eb26d84271a7a1f8d6c250cd1a0d5e1181a40ba77a37776dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.0/platoon-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "2700b538b8f7a83cb711a2fa37db472cef94c36b3e53a7f024248696b674e740"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.5.0/platoon-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "0765986d40585ef8f30a8c5707967b8b092ebdb26c8a3a93f4da4d81a2ab78f9"
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
