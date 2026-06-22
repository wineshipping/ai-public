set -euo pipefail

export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$DOTNET_ROOT:$PATH"

# Persist for the agent phase; Codex setup scripts run in a separate Bash session.
grep -qxF 'export DOTNET_ROOT="$HOME/.dotnet"' ~/.bashrc || echo 'export DOTNET_ROOT="$HOME/.dotnet"' >> ~/.bashrc
grep -qxF 'export PATH="$HOME/.dotnet:$PATH"' ~/.bashrc || echo 'export PATH="$HOME/.dotnet:$PATH"' >> ~/.bashrc

curl -sSL https://dot.net/v1/dotnet-install.sh -o /tmp/dotnet-install.sh
chmod +x /tmp/dotnet-install.sh

# Currently supported major SDK lines as of Microsoft's docs: .NET 8.
bash /tmp/dotnet-install.sh --channel 8.0  --install-dir "$DOTNET_ROOT"

rm /tmp/dotnet-install.sh

dotnet --info
dotnet --list-sdks
dotnet restore