class Kaizero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/kaizero"
  url "https://github.com/IvanRublev/kaizero/archive/refs/tags/v0.1.10.tar.gz"
  sha256 "b878d572923129cd97f7cd9652738978f927840949132195b29f4d8636b74f8a"
  license "MIT"
  head "https://github.com/IvanRublev/kaizero", branch: "master"

  depends_on "flock" # serializes cross-instance worktree merges; script hard-requires it
  depends_on "tmux" # kz-tmux drives tmux sessions

  def install
    bin.install "kaizero.sh" => "kaizero"
    bin.install "kz-tmux.sh" => "kz-tmux"
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
