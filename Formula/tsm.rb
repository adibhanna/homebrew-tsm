class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.1/tsm_v0.6.1_darwin_arm64.tar.gz"
      sha256 "5c66101e6b9881886d651764cfb7c3fcc29b5eb90711f7903dc16201e7732a32"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.1/tsm_v0.6.1_darwin_amd64.tar.gz"
      sha256 "17136500fd572581faf93d71d9dfa27b56db336ea09ededbb69dbb981919d727"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.1/tsm_v0.6.1_linux_arm64.tar.gz"
      sha256 "3f6b1a9d72a8276fa246c396e4d250457a05f447cbecc6e50e6e50dfbfb15c27"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.6.1/tsm_v0.6.1_linux_amd64.tar.gz"
      sha256 "009c64963ef6a4602a155fe82516847999174414f560dbba5f61a90feb61de36"
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
