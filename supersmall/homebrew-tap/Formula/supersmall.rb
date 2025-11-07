class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/distribution/releases/download/supersmall-v5.2.1/supersmall-cli-v5.2.1-macos-universal.tar.gz"
  sha256 "cd2ed091341d25982d82cddba925504d70f87940b2767fa8ae66f0e9979625d1"
  license "MIT"
  version "5.2.1"

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
