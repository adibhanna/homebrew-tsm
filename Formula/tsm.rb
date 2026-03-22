class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.0/tsm_v0.5.0_darwin_arm64.tar.gz"
      sha256 "5c1bacba76a74d6e1696a3f91e50d8810f895ddc8de882ac26b5c10bd34e3c15"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.0/tsm_v0.5.0_darwin_amd64.tar.gz"
      sha256 "741a3bb765bd21240351f96a00354a63a5e82326c384b02cde7d7cf286316b9d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.0/tsm_v0.5.0_linux_arm64.tar.gz"
      sha256 "541833b5b95b34833c07f9de2cb809dae8d5b4972d4eda3b7156a558cd83ded6"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.0/tsm_v0.5.0_linux_amd64.tar.gz"
      sha256 "dbe76dc997114c728bb1266f2c1801515c1b26cf6ff90601efeac3a445b0bf40"
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
