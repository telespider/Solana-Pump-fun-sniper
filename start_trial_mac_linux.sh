#!/usr/bin/env bash
#
# start_trial.sh - Detect OS + arch and launch the matching pumpfun-sniper binary.
#
set -euo pipefail

# ---------------------------------------------------------------------------
# Locate the project root (dir containing this script) and the trial/ folder
# ---------------------------------------------------------------------------
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
BIN_DIR="${BIN_DIR:-$SCRIPT_DIR/trial}"

# Forward all CLI args to the binary
EXTRA_ARGS=("$@")

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
die() { printf 'error: %s\n' "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
# Pick binary based on OS + arch
# ---------------------------------------------------------------------------
BIN_PATH=""

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Linux)
        case "$ARCH" in
            x86_64|amd64)   BIN_PATH="$BIN_DIR/pumpfun-sniper-linux-x86_64" ;;
            aarch64|arm64)  BIN_PATH="$BIN_DIR/pumpfun-sniper-linux-aarch64" ;;
            *)              die "unsupported Linux arch: $ARCH (only x86_64/aarch64 builds)" ;;
        esac
        ;;
    Darwin)
        case "$ARCH" in
            arm64|x86_64)   BIN_PATH="$BIN_DIR/pumpfun-sniper-mac-darwin" ;;
            *)              die "unsupported macOS arch: $ARCH" ;;
        esac
        ;;
    MINGW*|MSYS*|CYGWIN*)
        BIN_PATH="$BIN_DIR/pumpfun-sniper.exe"
        ;;
    *)
        die "unsupported OS: $OS"
        ;;
esac

# ---------------------------------------------------------------------------
# Validate + exec
# ---------------------------------------------------------------------------
[[ -f "$BIN_PATH" ]] || die "binary not found: $BIN_PATH"

if [[ ! -x "$BIN_PATH" ]]; then
    chmod +x "$BIN_PATH" 2>/dev/null || true
    [[ -x "$BIN_PATH" ]] || die "binary not executable: $BIN_PATH"
fi

printf 'info: OS=%s ARCH=%s -> %s\n' "$OS" "$ARCH" "$BIN_PATH" >&2

exec "$BIN_PATH" "${EXTRA_ARGS[@]}"