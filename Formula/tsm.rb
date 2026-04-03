class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.0/tsm_v0.7.0_darwin_arm64.tar.gz"
      sha256 "f61084db9484b1c15fc7656c7a65cfb6d7e2a90f05f7b491df044386f0c11d76"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.0/tsm_v0.7.0_darwin_amd64.tar.gz"
      sha256 "0064fb210bdf4b303b577c5d2f3baa5b3d61f1ea306f4d7f568506b914ee53dc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.0/tsm_v0.7.0_linux_arm64.tar.gz"
      sha256 "24d3786b8807257777c94e89a70b5307b46190e54080452939e9d33c6d249724"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.7.0/tsm_v0.7.0_linux_amd64.tar.gz"
      sha256 "e05f8f74b1ac5d1f033013167bac157092814c5731d58b4af68f5ab37e7c4b1d"
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
