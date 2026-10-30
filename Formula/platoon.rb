class Platoon < Formula
  desc "A terminal app for running and managing Claude Code and Codex sessions: every conversation in one list, projects with notes, tasks run by squads"
  homepage "https://github.com/ctrader2/platoon"
  version "1.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.4.0/platoon-tui-aarch64-apple-darwin.tar.xz"
      sha256 "2845260b9665a98f31019d463f9edfafb642478fa2790ed8c8ca8ab9e962ebb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.4.0/platoon-tui-x86_64-apple-darwin.tar.xz"
      sha256 "928ac536f4bbd28c7bd6da04116392915d45d7e93b16c46579e968e8d51f3fb0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ctrader2/platoon/releases/download/v1.4.0/platoon-tui-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5ae72a28e4c24e87383955bd99b8ff26e6dee271ba6aa9cd7186d7e7f13253d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ctrader2/platoon/releases/download/v1.4.0/platoon-tui-x86_64-unknown-linux-musl.tar.xz"
      sha256 "1ab2da3d93bb53aba0e046785ace4854061825311b0626ee0a45f989d1f3ef99"
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
