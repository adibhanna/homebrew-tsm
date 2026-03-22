class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.1/tsm_v0.5.1_darwin_arm64.tar.gz"
      sha256 "a435e491b9fa4d85a2e2ac68ba503543d14676bae3fb38336cc95ddbb70b2fc2"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.1/tsm_v0.5.1_darwin_amd64.tar.gz"
      sha256 "ceb247994d9160732c1f6a6a48f5560943bab9bb0d33070485b5e83e910226e6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.1/tsm_v0.5.1_linux_arm64.tar.gz"
      sha256 "d6abe8addb2a7289b75fe727a921cefbcb603dad88ed2a9d27d85cdc64171860"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.5.1/tsm_v0.5.1_linux_amd64.tar.gz"
      sha256 "9d3abc7ddb06fb9f8c53ca840fe59e8fe4c9678b16c81b94345438fe1e19ff25"
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
