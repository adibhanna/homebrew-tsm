class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.6/tsm_v0.6.6_darwin_arm64.tar.gz"
      sha256 "769636d4c22cdc950889ce26dba38b742c141e9abfcb4b44a24b7d7757851b96"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.6/tsm_v0.6.6_darwin_amd64.tar.gz"
      sha256 "98d2bb7276d6105d522c6281b74adf37b0cd02cb0b5c16c59f9bb5ee71934bd6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.6/tsm_v0.6.6_linux_arm64.tar.gz"
      sha256 "902399e8cd3aa22b37be35f662ff1c9d76770c12e13b517397746e554c97f66d"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.6/tsm_v0.6.6_linux_amd64.tar.gz"
      sha256 "63dbdf630288f999c8dddcfcf943c5deba18ef4d2eebae270d0dedaf6ebaf1a3"
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
