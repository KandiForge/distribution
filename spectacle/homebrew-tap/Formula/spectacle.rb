class Spectacle < Formula
  desc "Multi-service platform with server and CLI tools for AI-assisted development"
  homepage "https://github.com/KandiForge/apps"
  url "https://github.com/KandiForge/distribution/releases/download/spectacle-v0.3.25/spectacle-v0.3.25-macos-universal.tar.gz"
  sha256 "f3fce63fa02a805941865f29dc86e081eff424f824fd3c33cbe88c3f36bcd7b0"
  license "Proprietary"
  version "0.3.25"

  depends_on "ripgrep" => :optional  # For enhanced search functionality

  def install
    # Install all 7 binaries
    bin.install "kandi-spectacle"
    bin.install "kandi-plan"
    bin.install "kandi-gpt"
    bin.install "kandi-deploy"
    bin.install "kandi-secure"
    bin.install "kandi-forge"
    bin.install "kandi-supersmall"

    # Create convenience symlinks without kandi- prefix
    bin.install_symlink bin/"kandi-spectacle" => "spectacle"
    bin.install_symlink bin/"kandi-supersmall" => "supersmall"
  end

  def post_install
    # Create data directory
    (var/"kandi").mkpath

    # Create config directory
    (etc/"kandi").mkpath
  end

  def caveats
    <<~EOS
      Spectacle has been installed with all binaries:

      Main server:
        kandi-spectacle    - Start the Spectacle server (http://127.0.0.1:7428)
        spectacle          - Alias for kandi-spectacle

      CLI tools:
        kandi-plan         - GitHub Issues and project management
        kandi-gpt          - GPT integration
        kandi-deploy       - Deployment automation
        kandi-secure       - Security analysis
        kandi-forge        - Forge CLI
        kandi-supersmall   - Context optimization
        supersmall         - Alias for kandi-supersmall

      To start the server:
        spectacle

      The server will run on: http://127.0.0.1:7428

      Configuration:
        Data directory: #{var}/kandi/
        Config: #{etc}/kandi/

      For more information, visit:
        https://github.com/KandiForge/apps
    EOS
  end

  test do
    system "#{bin}/kandi-spectacle", "--version"
    system "#{bin}/kandi-plan", "--version"
    system "#{bin}/kandi-supersmall", "--version"
  end
end
