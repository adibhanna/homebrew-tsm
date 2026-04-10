class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.5/tsm_v0.6.5_darwin_arm64.tar.gz"
      sha256 "e4c47a66643b1c6b25a3148f5756c720ec7e326ac3f1a712f63897453cd55fb0"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.5/tsm_v0.6.5_darwin_amd64.tar.gz"
      sha256 "7af193cd92b1e182cdfd2d4886526a2e530cda3ab58c38c665d61856a3c9a012"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.5/tsm_v0.6.5_linux_arm64.tar.gz"
      sha256 "206714b97825068c93b846252e8486d532b7244ac5be578bcd035958c99396cc"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.5/tsm_v0.6.5_linux_amd64.tar.gz"
      sha256 "84eeeba595f50a0325439b578c88758e4d4e511d3e1bdaaf191f1ccbb921a525"
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
