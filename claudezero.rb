class Claudezero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/claudezero"
  url "https://github.com/IvanRublev/claudezero/archive/refs/tags/v0.0.14.tar.gz"
  sha256 "a9fa7bb0257bc753d2b66a6b119a5d02ef352a77f13f3a5b4cebc16efd15cdda"
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
