class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.4.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.2/tsm_v0.4.2_darwin_arm64.tar.gz"
      sha256 "63a918bdbdc4f05d8928897d22e74a384fdce1ad9ea98e220daf76f85bd0c525"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.2/tsm_v0.4.2_darwin_amd64.tar.gz"
      sha256 "d58de2f07f135ac645f967de077abeb591112292510701463ce165402f0c9314"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.2/tsm_v0.4.2_linux_arm64.tar.gz"
      sha256 "36215f4ec6b67d61d7150e7abb04db444de041bf71152517d7b56fb79459a1f0"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.2/tsm_v0.4.2_linux_amd64.tar.gz"
      sha256 "6154be237db61cc7ffdc7b876a0a22e3966000985df8a5bfd810ca5eb68fb97b"
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
