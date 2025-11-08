class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/distribution/releases/download/supersmall-v5.3.3/supersmall-cli-v5.3.3-macos-universal.tar.gz"
  sha256 "3fbf4b125afd60d088d4a3032b9b96afb45f74029fbabaf0f1a2667ed7ddacae"
  license "MIT"
  version "5.3.3"

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
