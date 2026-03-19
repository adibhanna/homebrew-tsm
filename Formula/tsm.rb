class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.0/tsm_v0.4.0_darwin_arm64.tar.gz"
      sha256 "45f8b1e337c0a842ae6c8eac1adab6c65dc1e6998b5808570c9da52aee85ddd8"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.0/tsm_v0.4.0_darwin_amd64.tar.gz"
      sha256 "9d9bdf728250023410304bbd03ab1dfd716216cec5d4b9e7126a1f9a1533db7f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.0/tsm_v0.4.0_linux_arm64.tar.gz"
      sha256 "6a56cc575dac3e48f577278d25d1f319bd3caa45aec676a930d7d44afbd95567"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.0/tsm_v0.4.0_linux_amd64.tar.gz"
      sha256 "a5308c4964f924d3dadeab97f79c20813449b68ead4040d647861c0ddfde47c2"
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
