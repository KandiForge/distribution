class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://raw.githubusercontent.com/KandiForge/distribution/main/supersmall/binaries/supersmall-cli-v5.0.2-macos-universal.tar.gz"
  sha256 "263ac1410a187d174955dcf78b6c95813f2c555267770eca8eee0b27f5ddf093"
  license "MIT"
  version "5.0.2"

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
