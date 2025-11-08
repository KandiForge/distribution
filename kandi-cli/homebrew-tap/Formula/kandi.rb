class Kandi < Formula
  desc "AI-assisted software development CLI with interactive chat and 26 built-in tools"
  homepage "https://github.com/KandiForge/apps"
  url "https://github.com/KandiForge/distribution/releases/download/kandi-cli-v9.3.1/kandi-cli-v9.3.1-macos-universal.tar.gz"
  sha256 "05c4bb76235b0dddf07ec75331416db7df42fa04cfc3bb896af99e4dcedde672"
  license "Proprietary"
  version "9.3.1"

  depends_on "ripgrep" => :optional  # For enhanced search functionality

  def install
    bin.install "kandi"
  end

  def post_install
    # Create config directory
    (var/"kandi").mkpath
  end

  def caveats
    <<~EOS
      To get started with Kandi CLI:

      1. Set up your API keys:
         kandi config set anthropic.api_key "your-api-key"
         kandi config set openai.api_key "your-api-key"
         kandi config set github.token "your-token"

      2. Start an interactive chat session:
         kandi chat --allow-all

      3. Execute a coding task:
         kandi code "Create a Python script that prints hello world"

      4. Run a spec file:
         kandi exec-spec /path/to/spec.md

      Configuration is stored in: #{var}/kandi/config.yaml

      For more information, visit: https://github.com/KandiForge/apps
    EOS
  end

  test do
    system "#{bin}/kandi", "version"
  end
end
