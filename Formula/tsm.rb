class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.4/tsm_v0.6.4_darwin_arm64.tar.gz"
      sha256 "adea7ed4ea5c6d9bbcbf6bd0526f4cc04a04f57efb0874e932ae6f8df94fd0bb"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.4/tsm_v0.6.4_darwin_amd64.tar.gz"
      sha256 "93ebbeb92f0a5ba01b02f85794f0dbb1b57b6da3b1710f783ef95915016b7d30"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.4/tsm_v0.6.4_linux_arm64.tar.gz"
      sha256 "df324006c0f600d35929e7c6642a46d5c4992a99222271be5ae95ec35984564a"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.4/tsm_v0.6.4_linux_amd64.tar.gz"
      sha256 "831cad936a0f50bcd98b5b80e1555e94f7b2d10f642044c8864445f87f6f7d83"
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
