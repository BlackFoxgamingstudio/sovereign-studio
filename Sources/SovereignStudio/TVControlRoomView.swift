import SwiftUI
import AppKit

struct TVControlRoomView: View {
    @State private var selectedCamera = "CAM_01"
    @State private var tickerTheme = "#FF3366"
    @State private var activePreset = "16:9 UHD (Presentation PiP)"
    @State private var isLiveOnAir = true
    @State private var useLiveStageView = true
    @State private var reloadStage = false
    @State private var currentProjectId = "proj-yt-ep01-599-mainframe"
    @State private var crawlText = "BREAKING: Sovereign Biz Box replaces commercial SaaS with zero cloud egress fees  ★  MARKETS: Privacy-First AI Automation up 34%  ★  ALL PIPELINES HEALTHY"
    
    let cameraAngles = [
        ("CAM_01", "Wide Studio", "video.fill"),
        ("CAM_02", "Anchor Closeup", "person.crop.square.fill"),
        ("CAM_03", "Data Split Screen", "rectangle.split.2x1.fill"),
        ("CAM_04", "PiP Slide View", "pip.fill")
    ]
    
    var stageURL: URL {
        URL(string: "http://127.0.0.1:8812/stage?project_id=\(currentProjectId)")!
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Bar
            HStack(spacing: 12) {
                HStack(spacing: 8) {
                    LivePulseDot(color: isLiveOnAir ? .sbbCrimsonLive : .sbbTextMuted, size: 7)
                    Text(isLiveOnAir ? "LIVE ON AIR" : "STANDBY")
                        .font(.system(size: 11, weight: .black, design: .monospaced))
                        .foregroundColor(isLiveOnAir ? .sbbCrimsonLive : .sbbTextMuted)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.sbbSurfaceElevated)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(isLiveOnAir ? Color.sbbCrimsonLive.opacity(0.5) : Color.sbbBorder, lineWidth: 1))
                
                Text("TV Broadcast Control Room — Port 8812")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                // View Mode Toggle
                HStack(spacing: 4) {
                    Button(action: {
                        useLiveStageView = true
                    }) {
                        Text("16:9 MASTER STAGE")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(useLiveStageView ? .white : .sbbTextMuted)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(useLiveStageView ? Color.sbbElectricBlue : Color.clear)
                            .cornerRadius(2)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        useLiveStageView = false
                    }) {
                        Text("STUDIO CAMS")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(!useLiveStageView ? .white : .sbbTextMuted)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(!useLiveStageView ? Color.sbbElectricBlue : Color.clear)
                            .cornerRadius(2)
                    }
                    .buttonStyle(.plain)
                }
                .padding(2)
                .background(Color.sbbSurfaceElevated)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                
                // Reload stage button
                Button(action: {
                    reloadStage = true
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.sbbNeonCyan)
                        .padding(5)
                        .background(Color.sbbSurfaceElevated)
                        .cornerRadius(3)
                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                }
                .buttonStyle(.plain)
                .help("Refresh Broadcast Feed")
                
                // Open external stage
                Button(action: {
                    NSWorkspace.shared.open(stageURL)
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.up.right.square")
                        Text("OPEN STAGE")
                    }
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.sbbNeonCyan)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.sbbSurfaceElevated)
                    .cornerRadius(3)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.sbbSurface)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color.sbbBorder), alignment: .bottom)
            
            // 16:9 Main Stage Monitor
            GeometryReader { geo in
                ZStack(alignment: .bottom) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.sbbSurface)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.sbbBorder, lineWidth: 1)
                        )
                    
                    if useLiveStageView {
                        // Live HTML5 Web Audio / Video Stage Player directly embedded
                        EmbeddedWebView(url: stageURL, reloadTrigger: $reloadStage)
                            .cornerRadius(2)
                    } else {
                        // Multi-Camera Simulation Layout
                        VStack(spacing: 16) {
                            HStack {
                                Text("SOVEREIGN NEWS NETWORK (SNN) — UHD 4K MASTER FEED")
                                    .font(.system(size: 11, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sbbNeonCyan)
                                Spacer()
                                HStack(spacing: 6) {
                                    LivePulseDot(color: .sbbNeonMagenta, size: 5)
                                    Text("ACTIVE: " + selectedCamera)
                                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.sbbSurfaceElevated)
                                .cornerRadius(2)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.sbbBorder, lineWidth: 1))
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                            
                            HStack(spacing: 16) {
                                // Anchor Box
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.sbbSurfaceElevated)
                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                                    VStack(spacing: 8) {
                                        Image(systemName: "person.crop.rectangle.fill")
                                            .font(.system(size: 44))
                                            .foregroundColor(.sbbElectricBlue)
                                        Text("SOVEREIGN AI ANCHOR")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                        Text("Emotion: Confident | Cadence: 140 WPM")
                                            .font(.system(size: 10, design: .monospaced))
                                            .foregroundColor(.sbbTextSecondary)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                // Data Slide PiP
                                ZStack {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.sbbSurfaceElevated)
                                        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbNeonCyan.opacity(0.4), lineWidth: 1))
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Episode 1: The $599 Business Mainframe")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.sbbNeonCyan)
                                        Text("• 33 Microservices on Local Bare-Metal\n• Zero Cloud Egress Fees\n• Apple Silicon Hardware Acceleration\n• n8n Autonomous Pipelines Active")
                                            .font(.system(size: 10, design: .monospaced))
                                            .foregroundColor(.sbbTextPrimary)
                                        Spacer()
                                        HStack {
                                            Text("Uptime: 99.99%")
                                                .font(.system(size: 9, design: .monospaced))
                                                .foregroundColor(.sbbActiveGreen)
                                            Spacer()
                                            Text("Port: 8812")
                                                .font(.system(size: 9, design: .monospaced))
                                                .foregroundColor(.sbbTextSecondary)
                                        }
                                    }
                                    .padding(14)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .padding(.horizontal, 20)
                            
                            Spacer()
                        }
                        
                        // SNN Lower-Third Dynamic Ticker Overlay
                        VStack(spacing: 0) {
                            HStack(spacing: 10) {
                                Text("BREAKING")
                                    .font(.system(size: 10, weight: .black, design: .monospaced))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.sbbCrimsonLive)
                                    .cornerRadius(2)
                                
                                Text(crawlText)
                                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                                    .foregroundColor(.white)
                                    .lineLimit(1)
                                
                                Spacer()
                                
                                Text("NET EGRESS: $0.00")
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sbbActiveGreen)
                                    .padding(.trailing, 8)
                            }
                            .padding(8)
                            .background(Color.sbbBackground.opacity(0.95))
                            .cornerRadius(3)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                        }
                        .padding(16)
                    }
                }
                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(16)
            }
            .background(Color.sbbBackground)
            
            // Control Bar & Actions
            HStack(spacing: 10) {
                Text("CAMERAS:")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.sbbTextMuted)
                
                ForEach(cameraAngles, id: \.0) { cam in
                    Button(action: {
                        selectedCamera = cam.0
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: cam.2)
                                .font(.system(size: 11))
                            Text(cam.0 + ": " + cam.1)
                                .font(.system(size: 11, weight: selectedCamera == cam.0 ? .bold : .medium))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(selectedCamera == cam.0 ? Color.sbbElectricBlue : Color.sbbSurfaceElevated)
                        .foregroundColor(selectedCamera == cam.0 ? .white : .sbbTextSecondary)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(selectedCamera == cam.0 ? Color.sbbElectricBlue : Color.sbbBorder, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
                
                Button(action: {
                    deployStoryboardToTV()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "tv.fill")
                        Text("Deploy Show to Stage")
                    }
                    .font(.system(size: 11, weight: .bold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.sbbElectricBlue)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    triggerSimulcast()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("Live Simulcast")
                    }
                    .font(.system(size: 11, weight: .bold))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(Color.sbbCrimsonLive)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.sbbSurface)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color.sbbBorder), alignment: .top)
        }
        .background(Color.sbbBackground)
    }
    
    private func deployStoryboardToTV() {
        guard let url = URL(string: "http://127.0.0.1:8815/api/projects/\(currentProjectId)/deploy-to-tv") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { _, _, _ in
            DispatchQueue.main.async {
                self.reloadStage = true
            }
        }.resume()
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
        URLSession.shared.dataTask(with: request) { _, _, _ in
            DispatchQueue.main.async {
                self.reloadStage = true
            }
        }.resume()
    }
}
