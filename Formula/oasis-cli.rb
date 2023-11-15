class OasisCli < Formula
  desc "Official CLI for interacting with Oasis Network"
  homepage "https://oasisprotocol.org/"
  url "https://github.com/oasisprotocol/cli/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "ed59a5b50538d4ceda745c6b2e9211324731bcbcd5c58962243c25b250298e3e"
  license "Apache-2.0"
  head "https://github.com/oasisprotocol/cli.git", branch: "master"

  bottle do
    root_url "https://github.com/munaynetwork/homebrew-formulae/releases/download/oasis-cli-0.6.0"
    sha256 cellar: :any_skip_relocation, monterey:     "78dd34edc818c0135a851bfbeaa0f3640cf70eeb5e73e79a056be8231c30cd22"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "83a74190ef2d3ad2a17bc7e6983fcf93e29fa8d9af89b86cad36eff5678a8720"
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
