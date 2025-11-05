class Supersmall < Formula
  desc "Context optimization CLI tool with SuperSmall API integration"
  homepage "https://supersmall.dev"
  url "https://raw.githubusercontent.com/KandiForge/distribution/main/supersmall/binaries/supersmall-cli-v4.2.10-macos-universal.tar.gz"
  sha256 "bdacabacfafe10f2d8f3bccc3924160a05521dd05781b5517e3d0e10d9c6a0e8"
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
