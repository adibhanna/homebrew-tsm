class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.0/tsm_v0.6.0_darwin_arm64.tar.gz"
      sha256 "f99d72b72409ebeb5e82b6d7fdb943bcf987cbe9fb8955f1bdf39bb5555df9da"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.0/tsm_v0.6.0_darwin_amd64.tar.gz"
      sha256 "dfe7e8c10c3fd4d0e0e56f038bcb0044f2fe4d53428484ce5fc020bacddd06aa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.0/tsm_v0.6.0_linux_arm64.tar.gz"
      sha256 "1b3610f54a731eb8d71f7f7a89918d871f62821b5727c00a9ef276967ee48985"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.0/tsm_v0.6.0_linux_amd64.tar.gz"
      sha256 "8ad20e79f2c0c8d11fba6b8cac26bf6435f4734e069e064ed89d5acec603d44c"
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
