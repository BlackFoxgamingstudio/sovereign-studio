import SwiftUI

struct TVControlRoomView: View {
    @State private var selectedCamera = "CAM_01"
    @State private var tickerTheme = "#FF3B30"
    @State private var activePreset = "16:9 UHD (Presentation PiP)"
    @State private var isLiveOnAir = true
    @State private var crawlText = "BREAKING: Sovereign Biz Box replaces commercial SaaS with zero cloud egress fees  ★  MARKETS: Privacy-First AI Automation up 34%  ★  ALL PIPELINES HEALTHY"
    
    let cameraAngles = [
        ("CAM_01", "Wide Studio", "video.fill"),
        ("CAM_02", "Anchor Closeup", "person.crop.square.fill"),
        ("CAM_03", "Data Split Screen", "rectangle.split.2x1.fill"),
        ("CAM_04", "PiP Slide View", "pip.fill")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack {
                HStack(spacing: 8) {
                    Circle()
                        .fill(isLiveOnAir ? Color.red : Color.gray)
                        .frame(width: 10, height: 10)
                    Text(isLiveOnAir ? "LIVE ON AIR" : "STANDBY")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(isLiveOnAir ? .red : .gray)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color.red.opacity(0.15))
                .cornerRadius(6)
                
                Text("TV Broadcast Control Room — Port 8812")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text("Stage: " + activePreset)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
                    .foregroundColor(.cyan)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.cyan.opacity(0.12))
                    .cornerRadius(4)
            }
            .padding(12)
            .background(Color(nsColor: .windowBackgroundColor).opacity(0.9))
            
            Divider()
            
            // 16:9 Main Stage Monitor
            GeometryReader { geo in
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.07, green: 0.09, blue: 0.14))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue.opacity(0.4), lineWidth: 2)
                        )
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("SOVEREIGN NEWS NETWORK (SNN) — UHD 4K MASTER FEED")
                                .font(.system(size: 13, weight: .bold, design: .monospaced))
                                .foregroundColor(.cyan)
                            Spacer()
                            Text("ACTIVE: " + selectedCamera)
                                .font(.system(size: 12, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 20)
                        
                        // Visual Canvas Simulation
                        HStack(spacing: 20) {
                            // Anchor Box
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 0.12, green: 0.15, blue: 0.22))
                                VStack(spacing: 8) {
                                    Image(systemName: "person.crop.rectangle.fill")
                                        .font(.system(size: 48))
                                        .foregroundColor(.blue)
                                    Text("SOVEREIGN AI ANCHOR")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("Emotion: Confident | Cadence: 140 WPM")
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            // Data Slide PiP
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 0.10, green: 0.13, blue: 0.18))
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.cyan.opacity(0.3), lineWidth: 1))
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Episode 1: The $599 Business Mainframe")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundColor(.cyan)
                                    Text("• 33 Microservices on Local Bare-Metal\n• Zero Cloud Egress Fees\n• Apple Silicon Hardware Acceleration\n• n8n Autonomous Pipelines Active")
                                        .font(.system(size: 11, design: .monospaced))
                                        .foregroundColor(.white.opacity(0.9))
                                    Spacer()
                                    HStack {
                                        Text("Uptime: 99.99%")
                                            .font(.system(size: 10, design: .monospaced))
                                            .foregroundColor(.green)
                                        Spacer()
                                        Text("Port: 8812")
                                            .font(.system(size: 10, design: .monospaced))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(16)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer()
                    }
                    
                    // SNN Lower-Third Dynamic Ticker Overlay
                    VStack(spacing: 0) {
                        HStack(spacing: 12) {
                            Text("BREAKING")
                                .font(.system(size: 12, weight: .black, design: .monospaced))
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.red)
                                .cornerRadius(4)
                            
                            Text(crawlText)
                                .font(.system(size: 12, weight: .medium, design: .monospaced))
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text("NET EGRESS: $0.00")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.green)
                                .padding(.trailing, 8)
                        }
                        .padding(10)
                        .background(Color.black.opacity(0.85))
                        .cornerRadius(8)
                    }
                    .padding(16)
                }
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(16)
            }
            
            // Camera Switcher
            HStack(spacing: 12) {
                Text("CAMERAS:")
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                    .foregroundColor(.gray)
                
                ForEach(cameraAngles, id: \.0) { cam in
                    Button(action: {
                        selectedCamera = cam.0
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: cam.2)
                            Text(cam.0 + ": " + cam.1)
                                .font(.system(size: 11, weight: .medium))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedCamera == cam.0 ? Color.blue : Color(nsColor: .controlBackgroundColor))
                        .foregroundColor(selectedCamera == cam.0 ? .white : .primary)
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Button(action: {
                    triggerSimulcast()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("Trigger TV Broadcast")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                }
                .buttonStyle(.plain)
            }
            .padding(16)
            .background(Color(nsColor: .windowBackgroundColor).opacity(0.8))
        }
    }
    
    private func triggerSimulcast() {
        guard let url = URL(string: "http://127.0.0.1:8812/api/v1/execute") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("sbb_local_dev_secret_2026", forHTTPHeaderField: "X-SBB-Auth")
        let payload: [String: Any] = [
            "action": "create_live_broadcast",
            "payload": ["topic": "Sovereign Studio Desktop Switcher", "content": "Live camera switched to " + selectedCamera]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        URLSession.shared.dataTask(with: request).resume()
    }
}
