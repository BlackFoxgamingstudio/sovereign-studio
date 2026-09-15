#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "=================================================="
echo "⚡ SOVEREIGN STUDIO — BARE-METAL MAINFRAME DESKTOP"
echo "=================================================="

# 1. Check/Start Studio Bridge Daemon
if ! lsof -i :8820 > /dev/null 2>&1; then
    echo "Starting Sovereign Studio Bridge daemon on port 8820..."
    python3 "$DIR/backend/studio_bridge.py" > "$DIR/backend/bridge.log" 2>&1 &
    sleep 1
else
    echo "Sovereign Studio Bridge daemon already running on port 8820."
fi

# 2. Check/Start n8n Server with N8N_SECURE_COOKIE=false
if ! lsof -i :5678 > /dev/null 2>&1; then
    echo "Starting n8n Command Center on port 5678 (N8N_SECURE_COOKIE=false)..."
    bash "$DIR/../../sbb-n8n-command-center/start_local_n8n.sh" > /dev/null 2>&1 &
    sleep 3
else
    echo "n8n Command Center already running on port 5678."
fi

# 2. Build Release binary if not built
if [ ! -f "$DIR/.build/release/SovereignStudio" ]; then
    echo "Building Sovereign Studio release binary..."
    swift build -c release
fi

echo "Launching Sovereign Studio Native macOS App..."
"$DIR/.build/release/SovereignStudio"
