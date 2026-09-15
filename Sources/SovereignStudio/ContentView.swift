import SwiftUI

enum StudioTab: String, CaseIterable, Identifiable {
    case n8n = "n8n Command Center"
    case storyboard = "Storyboard AI Studio"
    case tvControl = "TV Broadcast Stage"
    case aiRadio = "AI Radio Station"
    case repoImporter = "Repo Importer"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .n8n: return "bolt.horizontal.fill"
        case .storyboard: return "film.stack.fill"
        case .tvControl: return "play.tv.fill"
        case .aiRadio: return "radio.fill"
        case .repoImporter: return "arrow.down.circle.fill"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: StudioTab = .n8n
    @State private var reloadN8N = false
    @State private var reloadStoryboard = false
    
    let n8nURL = URL(string: "http://localhost:5678")!
    let storyboardURL = URL(string: "http://localhost:8815")!
    
    var body: some View {
        NavigationSplitView {
            // Sidebar Navigation
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 10) {
                    Image(systemName: "cpu.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("SOVEREIGN STUDIO")
                            .font(.system(size: 13, weight: .black, design: .monospaced))
                            .foregroundColor(.white)
                        Text("Bare-Metal Mainframe")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                
                Divider()
                
                List(StudioTab.allCases, selection: $selectedTab) { tab in
                    NavigationLink(value: tab) {
                        Label {
                            Text(tab.rawValue)
                                .font(.system(size: 12, weight: .medium))
                        } icon: {
                            Image(systemName: tab.icon)
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(.sidebar)
                
                Spacer()
                
                // System Telemetry Footer
                VStack(alignment: .leading, spacing: 4) {
                    Text("ACTIVE DAEMONS (6):")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.gray)
                    HStack {
                        Circle().fill(Color.green).frame(width: 8, height: 8)
                        Text("n8n (5678) • Storyboard (8815)")
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    HStack {
                        Circle().fill(Color.green).frame(width: 8, height: 8)
                        Text("TV (8812) • Radio (8811)")
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    Text("Cloud Cost: $0.00 / Mo")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.green)
                }
                .padding(14)
                .background(Color.black.opacity(0.3))
                .cornerRadius(8)
                .padding(10)
            }
            .frame(minWidth: 240, idealWidth: 260, maxWidth: 300)
        } detail: {
            switch selectedTab {
            case .n8n:
                VStack(spacing: 0) {
                    HStack {
                        Text("n8n Command Center — Embedded Native Engine")
                            .font(.headline)
                        Spacer()
                        Button(action: { reloadN8N = true }) {
                            Image(systemName: "arrow.clockwise")
                            Text("Reload")
                        }
                    }
                    .padding(10)
                    .background(Color(nsColor: .windowBackgroundColor))
                    
                    Divider()
                    
                    EmbeddedWebView(url: n8nURL, reloadTrigger: $reloadN8N)
                }
            case .storyboard:
                VStack(spacing: 0) {
                    HStack {
                        Text("Storyboard AI Studio — Gemini 2.5 Flash")
                            .font(.headline)
                        Spacer()
                        Button(action: { reloadStoryboard = true }) {
                            Image(systemName: "arrow.clockwise")
                            Text("Reload")
                        }
                    }
                    .padding(10)
                    .background(Color(nsColor: .windowBackgroundColor))
                    
                    Divider()
                    
                    EmbeddedWebView(url: storyboardURL, reloadTrigger: $reloadStoryboard)
                }
            case .tvControl:
                TVControlRoomView()
            case .aiRadio:
                AIRadioDeskView()
            case .repoImporter:
                RepoImporterView()
            }
        }
        .frame(minWidth: 1100, minHeight: 700)
    }
}
