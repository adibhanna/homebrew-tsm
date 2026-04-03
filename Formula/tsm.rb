class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.1/tsm_v0.7.1_darwin_arm64.tar.gz"
      sha256 "afbca2c42f8ba66be2ef7c026c22d8d0d60ab673f345f64228a2c67f74850a2c"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.1/tsm_v0.7.1_darwin_amd64.tar.gz"
      sha256 "342f111c996135c411aea0400cd9453edb9dcb8e6d455c621541f49c6dbbc3de"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.1/tsm_v0.7.1_linux_arm64.tar.gz"
      sha256 "506456135db4176199c552c7fd523d473d935a911a7dd721b85449b51cc9e78f"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.1/tsm_v0.7.1_linux_amd64.tar.gz"
      sha256 "ee79e7c04b7595bb223ed4843be7b7370a5646636df184a9361b3b737aa0ff03"
    end
  end

  def install
    entries = Dir[buildpath/"*"]
    if entries.length == 1 && File.directory?(entries.first)
      entries = Dir[entries.first/"*"]
    end
    raise "unexpected archive layout" if entries.empty?

    libexec.install entries
    (bin/"tsm").write_env_script(libexec/"tsm", {})
  end

  test do
    assert_match "tsm", shell_output("#{bin}/tsm help")
    assert_match "backend=libghostty-vt", shell_output("#{bin}/tsm version")
  end
end
