class Claudezero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/claudezero"
  url "https://github.com/IvanRublev/claudezero/archive/refs/tags/v0.0.15.tar.gz"
  sha256 "2bc5b4eb280aaac5f129723c1c58fd34d2248f3686b0b6c26cf2e858826ac099"
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
