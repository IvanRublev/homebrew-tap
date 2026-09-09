class Kaizero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/kaizero"
  url "https://github.com/IvanRublev/kaizero/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "b1415f16266046f145801776e8413ccf53d4386366bd151de348c569618249ca"
  license "MIT"
  head "https://github.com/IvanRublev/kaizero", branch: "master"

  depends_on "flock" # serializes cross-instance worktree merges; script hard-requires it

  def install
    bin.install "kaizero.sh" => "kaizero"
    doc.install "README.md"
  end

  # Run the script's own prerequisite check (the single source of truth) as the final install
  # step. Non-fatal: a missing hook/claude prints an actionable command but must not abort install.
  def post_install
    system "sh", "-c", "#{bin}/kaizero --doctor || true"
  end

  test do
    assert_match "usage: kaizero", shell_output("#{bin}/kaizero -h")
  end
end
