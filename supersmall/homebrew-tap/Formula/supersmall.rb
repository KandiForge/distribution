class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/distribution/releases/download/supersmall-v5.3.0/supersmall-cli-v5.3.0-macos-universal.tar.gz"
  sha256 "944cb879012aefc43877701809b27e5ac6fcf02afb317e4292aa083cbd318c29"
  license "MIT"
  version "5.3.0"

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
