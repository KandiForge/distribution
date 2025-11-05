class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/apps/releases/download/supersmall-v4.2.10/supersmall-cli-v4.2.10-macos-universal.tar.gz"
  sha256 "5df44789c342d4d063b1ea8fae4570fcb67459596205dca06221edf50aaf48f9"
  license "MIT"
  version "4.2.10"

  def install
    bin.install "supersmall"
  end

  def caveats
    <<~EOS
      To get started with SuperSmall CLI:

      1. Set up your API key:
         supersmall config set api-key "your-api-key"

      2. Optimize a file:
         supersmall optimize input.txt

      3. Check your usage:
         supersmall usage

      For more information, visit: https://supersmall.dev
    EOS
  end

  test do
    system "#{bin}/supersmall", "--version"
  end
end
