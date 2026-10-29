class Platoon < Formula
  desc "A terminal app for running and managing Claude Code and Codex sessions: every conversation in one list, projects with notes, tasks run by squads"
  homepage "https://github.com/ctrader2/platoon"
  version "1.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.3.0/platoon-tui-aarch64-apple-darwin.tar.xz"
      sha256 "fdeeb93c5365bf267bfab442b05ea5d62ef3fd9c25bf26079eff309faad8ffcf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.3.0/platoon-tui-x86_64-apple-darwin.tar.xz"
      sha256 "f8987f1cfafef63b77a1c2fcb361d116cdd4e25707d1ce070f5fbe3201566f52"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.3.0/platoon-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "30ef9106a3628a4e993db56ca53fea742f651df8f30c1a4d7c7ed7eac682f2d7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.3.0/platoon-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8cd4e4b799071982ec490f63ca8080e98f81f23225c25ee6e170ec260ee6963c"
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
