class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://github.com/KandiForge/distribution/releases/download/supersmall-v5.3.4/supersmall-cli-v5.3.4-macos-universal.tar.gz"
  sha256 "4d376a93ceda0e3d9978e107305df502be7a3d0e4011beac9a2d11f3206989c9"
  license "MIT"
  version "5.3.4"

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
