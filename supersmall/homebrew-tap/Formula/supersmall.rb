class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://raw.githubusercontent.com/KandiForge/distribution/main/supersmall/binaries/supersmall-cli-v5.0.0-macos-universal.tar.gz"
  sha256 "f5d7a1a0679d22360fc9008eb8526c01acc129f134971bebf327e97c95c2612f"
  license "MIT"
  version "5.0.0"

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
