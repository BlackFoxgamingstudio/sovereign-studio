import SwiftUI

enum StudioTab: String, CaseIterable, Identifiable {
    case matrix = "Mainframe Matrix"
    case n8n = "n8n Command Center"
    case storyboard = "Storyboard AI Studio"
    case tvControl = "TV Broadcast Stage"
    case aiRadio = "AI Radio Station"
    case repoImporter = "Repo Importer"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .matrix: return "chart.xyaxis.line"
        case .n8n: return "bolt.horizontal.fill"
        case .storyboard: return "film.stack.fill"
        case .tvControl: return "play.tv.fill"
        case .aiRadio: return "radio.fill"
        case .repoImporter: return "arrow.down.circle.fill"
        }
    }
    
    var accentColor: Color {
        switch self {
        case .matrix: return .sbbNeonMagenta
        case .n8n: return .sbbElectricBlue
        case .storyboard: return .sbbNeonCyan
        case .tvControl: return .sbbCrimsonLive
        case .aiRadio: return .sbbActiveGreen
        case .repoImporter: return .sbbElectricBlue
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: StudioTab = .matrix
    @State private var reloadN8N = false
    @State private var reloadStoryboard = false
    @State private var isLiveSimulcast = true
    
    let n8nURL = URL(string: "http://127.0.0.1:5678")!
    let storyboardURL = URL(string: "http://127.0.0.1:8815")!
    
    var body: some View {
        HStack(spacing: 0) {
            // MARK: - Left Sidebar (Fixed 260px Pro Layout)
            VStack(alignment: .leading, spacing: 0) {
                // Top Brand / Logo
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 10) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.sbbElectricBlue.opacity(0.2))
                                .frame(width: 32, height: 32)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 3)
                                        .stroke(Color.sbbElectricBlue, lineWidth: 1)
                                )
                            Image(systemName: "cpu.fill")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.sbbNeonCyan)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("SOVEREIGN STUDIO")
                                .font(.system(size: 12, weight: .black, design: .monospaced))
                                .foregroundColor(.white)
                            Text("BARE-METAL MAINFRAME // V2.5")
                                .font(.system(size: 9, weight: .bold, design: .monospaced))
                                .foregroundColor(.sbbNeonCyan)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 18)
                .padding(.bottom, 16)
                
                Rectangle()
                    .fill(Color.sbbBorder)
                    .frame(height: 1)
                
                // Section Title
                Text("MAINFRAME MODULES")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundColor(.sbbTextMuted)
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    .padding(.bottom, 6)
                
                // Navigation Items
                VStack(spacing: 4) {
                    ForEach(StudioTab.allCases) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            HStack(spacing: 10) {
                                // Active indicator bar
                                Rectangle()
                                    .fill(selectedTab == tab ? tab.accentColor : Color.clear)
                                    .frame(width: 3, height: 16)
                                    .cornerRadius(1)
                                
                                Image(systemName: tab.icon)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(selectedTab == tab ? tab.accentColor : .sbbTextSecondary)
                                    .frame(width: 18)
                                
                                Text(tab.rawValue)
                                    .font(.system(size: 12, weight: selectedTab == tab ? .semibold : .regular))
                                    .foregroundColor(selectedTab == tab ? .white : .sbbTextSecondary)
                                
                                Spacer()
                                
                                if tab == .matrix {
                                    Text("PRO")
                                        .font(.system(size: 8, weight: .bold, design: .monospaced))
                                        .foregroundColor(.sbbNeonMagenta)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Color.sbbNeonMagenta.opacity(0.15))
                                        .cornerRadius(2)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.trailing, 12)
                            .background(selectedTab == tab ? Color.sbbSurfaceElevated : Color.clear)
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(selectedTab == tab ? Color.sbbBorder : Color.clear, lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 10)
                    }
                }
                
                Spacer()
                
                // System Telemetry & Active Daemons Widget (Terminal Block)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        LivePulseDot(color: .sbbActiveGreen, size: 7)
                        Text("ACTIVE DAEMONS (6 LOCAL)")
                            .font(.system(size: 10, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                        Spacer()
                        Text("PORT MAP")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(.sbbNeonCyan)
                    }
                    
                    Rectangle().fill(Color.sbbBorder).frame(height: 1)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 6) {
                            Circle().fill(Color.sbbActiveGreen).frame(width: 5, height: 5)
                            Text("n8n: 5678  •  Storyboard: 8815")
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.sbbTextPrimary)
                        }
                        HStack(spacing: 6) {
                            Circle().fill(Color.sbbActiveGreen).frame(width: 5, height: 5)
                            Text("TV: 8812   •  Radio: 8811")
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.sbbTextPrimary)
                        }
                        HStack(spacing: 6) {
                            Circle().fill(Color.sbbActiveGreen).frame(width: 5, height: 5)
                            Text("Bridge: 8820 • RAG: 8802")
                                .font(.system(size: 9, design: .monospaced))
                                .foregroundColor(.sbbTextPrimary)
                        }
                    }
                    
                    Rectangle().fill(Color.sbbBorder).frame(height: 1)
                    
                    HStack {
                        Text("CLOUD EGRESS:")
                            .font(.system(size: 9, weight: .bold, design: .monospaced))
                            .foregroundColor(.sbbTextSecondary)
                        Spacer()
                        Text("$0.00 / Mo")
                            .font(.system(size: 10, weight: .black, design: .monospaced))
                            .foregroundColor(.sbbActiveGreen)
                    }
                }
                .padding(12)
                .background(Color.sbbSurface)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                .padding(12)
            }
            .frame(width: 260)
            .background(Color.sbbBackground)
            
            // Vertical Divider
            Rectangle()
                .fill(Color.sbbBorder)
                .frame(width: 1)
            
            // MARK: - Main Content Area + Top Header
            VStack(spacing: 0) {
                // Top Header Bar
                HStack(spacing: 12) {
                    // Breadcrumbs
                    HStack(spacing: 6) {
                        Text("MAINFRAME")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(.sbbTextSecondary)
                        Text("//")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(.sbbNeonCyan)
                        Text(selectedTab.rawValue.uppercased())
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    // API Key Selector & Status Badge
                    HStack(spacing: 6) {
                        Image(systemName: "key.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.sbbNeonCyan)
                        Text("Gemini 3.6 Flash ✓ | OpenAI gpt-image-1")
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.sbbSurfaceElevated)
                    .cornerRadius(3)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                    
                    // Primary Action: New Project Button
                    Button(action: {
                        // Open new project / quick action
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "plus")
                                .font(.system(size: 10, weight: .bold))
                            Text("New Project")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.sbbElectricBlue)
                        .cornerRadius(3)
                    }
                    .buttonStyle(.plain)
                    
                    // Alert / Live Simulcast Indicator Button
                    Button(action: {
                        isLiveSimulcast.toggle()
                    }) {
                        HStack(spacing: 6) {
                            LivePulseDot(color: .sbbCrimsonLive, size: 6)
                            Text(isLiveSimulcast ? "LIVE SIMULCAST" : "STANDBY")
                                .font(.system(size: 10, weight: .black, design: .monospaced))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(isLiveSimulcast ? Color.sbbCrimsonLive.opacity(0.85) : Color.sbbSurfaceElevated)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(isLiveSimulcast ? Color.sbbCrimsonLive : Color.sbbBorder, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                    
                    // Quick Reload Button
                    Button(action: {
                        if selectedTab == .n8n { reloadN8N = true }
                        if selectedTab == .storyboard { reloadStoryboard = true }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.sbbTextSecondary)
                            .padding(6)
                            .background(Color.sbbSurfaceElevated)
                            .cornerRadius(3)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .frame(height: 48)
                .background(Color.sbbSurface)
                
                Rectangle()
                    .fill(Color.sbbBorder)
                    .frame(height: 1)
                
                // Active Module Content
                ZStack {
                    Color.sbbBackground.ignoresSafeArea()
                    
                    switch selectedTab {
                    case .matrix:
                        MainframeMatrixView()
                    case .n8n:
                        EmbeddedWebView(url: n8nURL, reloadTrigger: $reloadN8N)
                    case .storyboard:
                        EmbeddedWebView(url: storyboardURL, reloadTrigger: $reloadStoryboard)
                    case .tvControl:
                        TVControlRoomView()
                    case .aiRadio:
                        AIRadioDeskView()
                    case .repoImporter:
                        RepoImporterView()
                    }
                }
            }
        }
        .frame(minWidth: 1180, minHeight: 740)
        .background(Color.sbbBackground)
    }
}
