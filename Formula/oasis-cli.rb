class OasisCli < Formula
  desc "Official CLI for interacting with Oasis Network"
  homepage "https://oasisprotocol.org/"
  url "https://github.com/oasisprotocol/cli/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "ed59a5b50538d4ceda745c6b2e9211324731bcbcd5c58962243c25b250298e3e"
  license "Apache-2.0"
  head "https://github.com/oasisprotocol/cli.git", branch: "master"

  bottle do
    root_url "https://github.com/munaynetwork/homebrew-formulae/releases/download/oasis-cli-0.6.0"
    sha256 cellar: :any_skip_relocation, monterey:     "4f3db2f99f4a47f590f013d3c56f06f28ed466c06347029beaf69ae8a125d7b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78e5665bb0797e1cd79f9aca483a493002ffc0ce8d143b024b50aa96845818f1"
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
    assert_match "Consensus layer operations", output

    output = shell_output("#{bin}/oasis network list 2>&1")
    assert_match "mainnet (*)	b11b369e0da5bb230b220127f5e7b242d385ef8c6f54906243f30af63c815535", output
  end
end
