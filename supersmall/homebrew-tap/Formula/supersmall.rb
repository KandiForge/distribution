class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://raw.githubusercontent.com/KandiForge/distribution/main/supersmall/binaries/supersmall-cli-v5.0.1-macos-universal.tar.gz"
  sha256 "949ead3ec0061a8ff02a13081ff525d7dc3dcd2f35dfd26c5c0623dfff4b386a"
  license "MIT"
  version "5.0.1"

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
