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

# 3. Check/Start Storyboard AI Backend on Port 8815
# 3. Check/Start Storyboard AI Backend on Port 8815
STORYBOARD_LOG="$DIR/backend/storyboard.log"
if ! lsof -i :8815 > /dev/null 2>&1; then
    echo "Starting Storyboard AI Backend on port 8815 (Logging to $STORYBOARD_LOG)..."
    STORYBOARD_DIR="/Users/russellpowers/Library/Mobile Documents/com~apple~CloudDocs/codingprojects/workingstoryboardai/backend"
    python3 -m uvicorn main:app --host 127.0.0.1 --port 8815 --app-dir "$STORYBOARD_DIR" >> "$STORYBOARD_LOG" 2>&1 &
    sleep 2
else
    echo "Storyboard AI Backend active on port 8815."
fi
echo "Live Telemetry Logs: tail -f \"$STORYBOARD_LOG\""

# 4. Compile latest release binary & package .app bundle
echo "Compiling Sovereign Studio release binary..."
swift build -c release

APP_DIR="$DIR/SovereignStudio.app"
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"
cp "$DIR/.build/release/SovereignStudio" "$APP_DIR/Contents/MacOS/SovereignStudio"
chmod +x "$APP_DIR/Contents/MacOS/SovereignStudio"

if [ ! -f "$APP_DIR/Contents/Info.plist" ]; then
    cat << 'EOF' > "$APP_DIR/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>SovereignStudio</string>
    <key>CFBundleIdentifier</key>
    <string>com.sovereign.studio</string>
    <key>CFBundleName</key>
    <string>Sovereign Studio</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>2.5</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</dict>
</plist>
EOF
fi

echo "🚀 Launching Sovereign Studio Native macOS App..."
open "$APP_DIR"
echo "=================================================="
echo "✓ Sovereign Studio is now running on your screen!"
echo "  (Dock icon is active. Window brought to foreground.)"
echo "=================================================="

