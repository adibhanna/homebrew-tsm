class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.2/tsm_v0.6.2_darwin_arm64.tar.gz"
      sha256 "8bf5cf5fe008c037c3435b4bed8b8e214b5fae48d11ade4e39ba7945c84baa19"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.2/tsm_v0.6.2_darwin_amd64.tar.gz"
      sha256 "28418bd9421b10545b59be7346aad317c54ce8f8dc18ac242020610a50dcb60a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.2/tsm_v0.6.2_linux_arm64.tar.gz"
      sha256 "3c5d72ebb780fdcb0f5655a2e3eeb4b6cdc2277d64e75d8a28e1906fb5e722e1"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.2/tsm_v0.6.2_linux_amd64.tar.gz"
      sha256 "853889fbebfc09b84fb606e755cb4028ec9917dd714fb51c9e657b8de3675425"
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
