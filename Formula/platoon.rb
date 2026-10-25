class Platoon < Formula
  desc "A terminal app for running and managing Claude Code and Codex sessions: every conversation in one list, projects with notes, tasks run by squads"
  homepage "https://github.com/ctrader2/platoon"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.0.0/platoon-tui-aarch64-apple-darwin.tar.xz"
      sha256 "43b7429de41d003786be7c3d218f29d6634ce0b0c73a56ad355ee415412e1456"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.0.0/platoon-tui-x86_64-apple-darwin.tar.xz"
      sha256 "fe81b6cd13218712333d06834f08ad73f2b677cc8e4afacd5b7af9f2ba116e26"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.0.0/platoon-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "d2ba4fa4f1baf8750cd85c20a5b42416b0d37f89a34e8072de6af6177b2bbdb2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.0.0/platoon-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4f2524b9a3f93f1ec58c84c8a34b4a8c5bb6a7e5122d8d70467c9c7f420cfbda"
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
