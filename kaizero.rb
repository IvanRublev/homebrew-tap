class Kaizero < Formula
  desc "Multiple Claude Code(s) implement, commit and check off a software spec todos"
  homepage "https://github.com/IvanRublev/kaizero"
  url "https://github.com/IvanRublev/kaizero/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "1056fffd7c980de5db5023f23ba45f15e5248c7795c9513d9fb8c49b4042c889"
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
