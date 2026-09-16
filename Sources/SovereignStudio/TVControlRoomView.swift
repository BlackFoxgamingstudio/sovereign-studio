import SwiftUI
import AppKit
import UniformTypeIdentifiers

struct TVControlRoomView: View {
    @State private var selectedCamera = "CAM_01"
    @State private var tickerTheme = "#FF3366"
    @State private var activePreset = "16:9 UHD (Presentation PiP)"
    @State private var isLiveOnAir = true
    @State private var useLiveStageView = true
    @State private var reloadStage = false
    @State private var isUploadingAudio = false
    @State private var isRenderingVideo = false
    @State private var uploadStatusMessage = ""
    @State private var showUploadAlert = false
    @State private var currentProjectId = "proj-chicago-chess-dream"
    @State private var crawlText = "BREAKING: Sovereign Biz Box replaces commercial SaaS with zero cloud egress fees  ★  MARKETS: Privacy-First AI Automation up 34%  ★  ALL PIPELINES HEALTHY"
    
    let availableProjects = [
        ("proj-chicago-chess-dream", "🎬 Sicilian Defense (16:16)"),
        ("proj-yt-ep01-599-mainframe", "📺 Ep 1: $599 Mainframe (01:20)")
    ]
    
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
            HStack(spacing: 10) {
                HStack(spacing: 6) {
                    LivePulseDot(color: isLiveOnAir ? .sbbCrimsonLive : .sbbTextMuted, size: 7)
                    Text(isLiveOnAir ? "LIVE" : "STANDBY")
                        .font(.system(size: 11, weight: .black, design: .monospaced))
                        .foregroundColor(isLiveOnAir ? .sbbCrimsonLive : .sbbTextMuted)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.sbbSurfaceElevated)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(isLiveOnAir ? Color.sbbCrimsonLive.opacity(0.5) : Color.sbbBorder, lineWidth: 1))
                
                // Show / Project Switcher
                HStack(spacing: 4) {
                    Image(systemName: "film.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.sbbNeonCyan)
                    Picker("SHOW:", selection: $currentProjectId) {
                        ForEach(availableProjects, id: \.0) { p in
                            Text(p.1).tag(p.0)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 220)
                    .font(.system(size: 10, weight: .bold))
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.sbbSurfaceElevated)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbNeonCyan.opacity(0.4), lineWidth: 1))
                .onChange(of: currentProjectId) { _ in
                    reloadStage = true
                }
                
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

                // Upload Audio / AIFF Track
                Button(action: {
                    selectAndUploadAudioTrack()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: isUploadingAudio ? "arrow.triangle.2.circlepath" : "music.note.badge.plus")
                            .font(.system(size: 11, weight: .bold))
                        Text(isUploadingAudio ? "SYNCING..." : "ADD MUSIC (AIFF)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                    }
                    .foregroundColor(.black)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color.sbbNeonCyan)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
                .disabled(isUploadingAudio)
                .help("Select an uncompressed AIFF exported from Logic Pro to sync with the 15 Save the Cat beats")

                // Export Video for YouTube
                Button(action: {
                    renderAndExportVideo()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: isRenderingVideo ? "arrow.triangle.2.circlepath" : "arrow.down.to.line.circle.fill")
                            .font(.system(size: 11, weight: .bold))
                        Text(isRenderingVideo ? "RENDERING..." : "EXPORT YOUTUBE (MP4)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 9)
                    .padding(.vertical, 5)
                    .background(Color.sbbCrimsonLive)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
                .disabled(isRenderingVideo)
                .help("Compile 16:9 1080p video with H.264 video, AAC audio, and Save the Cat! pacing for YouTube upload")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.sbbSurface)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color.sbbBorder), alignment: .bottom)
            
            // 16:9 Main Stage Monitor Area
            GeometryReader { geo in
                let padH: CGFloat = 16
                let padV: CGFloat = 10
                let availW = max(100, geo.size.width - (padH * 2))
                let availH = max(60, geo.size.height - (padV * 2))
                let targetW = min(availW, availH * (16.0 / 9.0))
                let targetH = targetW * (9.0 / 16.0)
                
                ZStack {
                    Color.sbbBackground
                    
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
                                            Text(currentProjectId == "proj-chicago-chess-dream" ? "The Sicilian Defense of Grant Park" : "Episode 1: The $599 Business Mainframe")
                                                .font(.system(size: 12, weight: .bold))
                                                .foregroundColor(.sbbNeonCyan)
                                            Text("• 15 Blake Snyder Save the Cat! Beats\n• 16:9 UHD Photorealistic Visuals\n• Sub-Second Logic Pro AIFF Audio Sync\n• 1080p YouTube Master Export Ready")
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
                    .frame(width: targetW, height: targetH)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .background(Color.sbbBackground)
            
            // Control Bar & Actions (pinned with layoutPriority so it is NEVER clipped)
            HStack(spacing: 8) {
                Text("CAMERAS:")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.sbbTextMuted)
                
                ForEach(cameraAngles, id: \.0) { cam in
                    Button(action: {
                        selectedCamera = cam.0
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: cam.2)
                                .font(.system(size: 10))
                            Text(cam.0 + ": " + cam.1)
                                .font(.system(size: 10, weight: selectedCamera == cam.0 ? .bold : .medium))
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
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
                    HStack(spacing: 5) {
                        Image(systemName: "tv.fill")
                        Text("Deploy Show to Stage")
                    }
                    .font(.system(size: 10, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.sbbElectricBlue)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
                
                Button(action: {
                    triggerSimulcast()
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                        Text("Live Simulcast")
                    }
                    .font(.system(size: 10, weight: .bold))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.sbbCrimsonLive)
                    .foregroundColor(.white)
                    .cornerRadius(3)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .frame(height: 48)
            .background(Color.sbbSurface)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color.sbbBorder), alignment: .top)
            .layoutPriority(1)
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
    
    private func selectAndUploadAudioTrack() {
        let panel = NSOpenPanel()
        panel.title = "Select Logic Pro Soundtrack (AIFF, WAV, MP3)"
        panel.prompt = "Sync to Show"
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = false
        panel.allowedContentTypes = [
            UTType(filenameExtension: "aif") ?? .audio,
            UTType(filenameExtension: "aiff") ?? .audio,
            UTType(filenameExtension: "aifc") ?? .audio,
            .mp3,
            .wav
        ]
        
        if panel.runModal() == .OK, let fileURL = panel.url {
            uploadAudioFile(fileURL: fileURL)
        }
    }
    
    private func uploadAudioFile(fileURL: URL) {
        isUploadingAudio = true
        uploadStatusMessage = "Syncing \(fileURL.lastPathComponent)..."
        
        let boundary = "Boundary-\(UUID().uuidString)"
        guard let url = URL(string: "http://127.0.0.1:8815/api/projects/\(currentProjectId)/audio") else {
            isUploadingAudio = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let fileData = try Data(contentsOf: fileURL)
                var body = Data()
                
                // File field
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileURL.lastPathComponent)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
                body.append(fileData)
                body.append("\r\n".data(using: .utf8)!)
                
                // auto_deploy field
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"auto_deploy\"\r\n\r\n".data(using: .utf8)!)
                body.append("true\r\n".data(using: .utf8)!)
                
                body.append("--\(boundary)--\r\n".data(using: .utf8)!)
                request.httpBody = body
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    DispatchQueue.main.async {
                        self.isUploadingAudio = false
                        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                            self.uploadStatusMessage = "✅ Successfully synced \(fileURL.lastPathComponent) to 15 Save the Cat beats!"
                            self.showUploadAlert = true
                            self.reloadStage.toggle()
                        } else {
                            self.uploadStatusMessage = "❌ Sync failed: \(error?.localizedDescription ?? "Server error")"
                            self.showUploadAlert = true
                        }
                    }
                }.resume()
            } catch {
                DispatchQueue.main.async {
                    self.isUploadingAudio = false
                    self.uploadStatusMessage = "Could not read file: \(error.localizedDescription)"
                    self.showUploadAlert = true
                }
            }
        }
    }
    
    private func renderAndExportVideo() {
        isRenderingVideo = true
        uploadStatusMessage = "🎬 Rendering 1080p YouTube Master Video with FFmpeg & Logic Pro Audio..."
        showUploadAlert = true
        
        guard let url = URL(string: "http://127.0.0.1:8812/api/v1/broadcast/render-video?project_id=\(currentProjectId)") else {
            isRenderingVideo = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isRenderingVideo = false
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let status = json["status"] as? String, status == "SUCCESS",
                      let filename = json["filename"] as? String else {
                    self.uploadStatusMessage = "❌ Video render failed: \(error?.localizedDescription ?? "Encoding error")"
                    self.showUploadAlert = true
                    return
                }
                
                let downloadsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first?.appendingPathComponent(filename)
                self.uploadStatusMessage = "✅ 1080p YouTube Video Ready! Saved to ~/Downloads/\(filename)"
                self.showUploadAlert = true
                
                if let targetURL = downloadsURL, FileManager.default.fileExists(atPath: targetURL.path) {
                    NSWorkspace.shared.activateFileViewerSelecting([targetURL])
                }
            }
        }.resume()
    }
}
