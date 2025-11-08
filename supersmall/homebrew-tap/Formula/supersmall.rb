class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/distribution/releases/download/supersmall-v5.2.1/supersmall-cli-v5.2.1-macos-universal.tar.gz"
  sha256 "efdf9613dfa5345d832bae11bd8706cb7613ac9035c4713bf1097eb27ead7f10"
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
