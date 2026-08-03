class Claudezero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/claudezero"
  url "https://github.com/IvanRublev/claudezero/archive/refs/tags/v0.0.16.tar.gz"
  sha256 "4a49c86c7e4a24813780d9c7ea67ae6c500e073363750fb86759e96e88166270"
  license "MIT"
  head "https://github.com/IvanRublev/claudezero", branch: "master"

  depends_on "flock" # serializes cross-instance worktree merges; script hard-requires it

  def install
    bin.install "claudezero.sh" => "claudezero"
    doc.install "README.md"
  end

  # Run the script's own prerequisite check (the single source of truth) as the final install
  # step. Non-fatal: a missing hook/claude prints an actionable command but must not abort install.
  def post_install
    system "sh", "-c", "#{bin}/claudezero --doctor || true"
  end

  test do
    assert_match "usage: claudezero", shell_output("#{bin}/claudezero -h")
  end
end
