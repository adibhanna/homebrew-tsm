class Tsm < Formula
  desc "Terminal session manager with persistent sessions"
  homepage "https://github.com/adibhanna/tsm"
  license "MIT"
  head "https://github.com/adibhanna/tsm.git", branch: "main"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.dirty=false"), "."
  end

  test do
    assert_match "tsm", shell_output("#{bin}/tsm help")
    assert_match "backend=mode-tracker", shell_output("#{bin}/tsm version")
  end
end
