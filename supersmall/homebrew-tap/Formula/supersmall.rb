class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://raw.githubusercontent.com/KandiForge/distribution/main/supersmall/binaries/supersmall-cli-v5.1.0-macos-universal.tar.gz"
  sha256 "89589761cbe84af748aee38712ab0ade26c1fd1059937f8c3d71d723182a13e7"
  license "MIT"
  version "5.1.0"

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
