class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.3/tsm_v0.6.3_darwin_arm64.tar.gz"
      sha256 "2d7ca3c41ad5c20ac79e61b651137388c273018cfbb04ccf8b5abcaec34f26cc"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.3/tsm_v0.6.3_darwin_amd64.tar.gz"
      sha256 "fa6a909911d9019f683d29ca07eb9516e09ded92dcf1902f174fe35bae5d7c9f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.3/tsm_v0.6.3_linux_arm64.tar.gz"
      sha256 "6da780821e5c5a7d2e45a2173d3011405903102ff8677afa9279f838cf82280f"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.3/tsm_v0.6.3_linux_amd64.tar.gz"
      sha256 "cae99b81782c3627a7352544936ab30a081c8a6cfe9f9236f9839685bb808afb"
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
