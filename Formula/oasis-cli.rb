class OasisCli < Formula
  desc "Official CLI for interacting with Oasis Network"
  homepage "https://oasisprotocol.org/"
  url "https://github.com/oasisprotocol/cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "ecd0834e41cb106c136ea00cd05b24915f288c78bfe0c54aa8ef8cb1e8dc9a9e"
  license "Apache-2.0"
  head "https://github.com/oasisprotocol/cli.git", branch: "master"

  bottle do
    root_url "https://github.com/munaynetwork/homebrew-formulae/releases/download/oasis-cli-0.1.0"
    sha256 cellar: :any_skip_relocation, monterey:     "1c3a28166b6bb60e07105aa9d5aa595d0c7b28f45de44c9ff6d74ca8cc29a97e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c1759324a64452da613a93a40126b0d9267b4010c9a517c578858cd04dfa5a72"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X github.com/oasisprotocol/cli/version.Software=v#{version}")

    # renaming binary to oasis, since that's how it's named upstream
    mv bin/"oasis-cli", bin/"oasis"
  end

  test do
    output = shell_output("#{bin}/oasis --help 2>&1")
    assert_match "CLI for interacting with the Oasis network", output

    output = shell_output("#{bin}/oasis accounts 2>&1")
    assert_match "Account operations", output

    output = shell_output("#{bin}/oasis network 2>&1")
    assert_match "Manage network endpoints", output

    output = shell_output("#{bin}/oasis network list 2>&1")
    assert_match "mainnet (*)	b11b369e0da5bb230b220127f5e7b242d385ef8c6f54906243f30af63c815535", output
  end
end
