class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  version "v0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.1/tsm_v0.4.1_darwin_arm64.tar.gz"
      sha256 "fb1e94ef6f86dfcd4865b5e6abe25ebcfc059415434ff7c66dbcb29ae65c6bf2"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.1/tsm_v0.4.1_darwin_amd64.tar.gz"
      sha256 "825347a5358decc01f728ab68298028ff7636cfdcf3c9a44dfa7028b459a167f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.1/tsm_v0.4.1_linux_arm64.tar.gz"
      sha256 "47bf3b072c96530a53c605ad4b4bd03280dac446687135d33b09a56f169160fd"
    else
      url "https://github.com/adibhanna/tsm/releases/download/v0.4.1/tsm_v0.4.1_linux_amd64.tar.gz"
      sha256 "8ec0dfb2037b7f45ceaab3eb4939d5928e9ec99e7c0929f2f1eaaabb78e7b58f"
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
