class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.7/tsm_v0.6.7_darwin_arm64.tar.gz"
      sha256 "603972596f43bead82333a13a4ff06b9af8a9e59b57efe21201bd58254b2049f"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.7/tsm_v0.6.7_darwin_amd64.tar.gz"
      sha256 "d39c1f56d23770e350c010b51dca6a9ff04e189e9e51da1938f344c3a52a93f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.7/tsm_v0.6.7_linux_arm64.tar.gz"
      sha256 "5fe524656abf3b1484f5fad6152562767e7e097bde9d0b32a27010a2f5e94db8"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.7/tsm_v0.6.7_linux_amd64.tar.gz"
      sha256 "4a3c99d670d9d2499de404051f4c7adcd00ef24b95fb062fd4f0c7c95955ecb2"
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
