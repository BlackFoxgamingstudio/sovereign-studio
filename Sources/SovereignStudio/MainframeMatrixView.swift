import SwiftUI

enum MatrixSubTab: String, CaseIterable, Identifiable {
    case pipelines = "Data Pipelines"
    case workflows = "Autonomous Agent Workflows"
    case matrixStatus = "Matrix Status"
    case telemetry = "Cloud Egress Telemetry"
    
    var id: String { rawValue }
}

struct MainframeMatrixView: View {
    @State private var selectedSubTab: MatrixSubTab = .workflows
    @State private var pulseState: Bool = false
    
    // Sample bar chart data for agent pipeline throughput
    let pipelineMetrics: [(name: String, value: CGFloat, color: Color, count: String)] = [
        ("Gemini 3.6 Ingestion", 0.85, .sbbNeonCyan, "2.4k req/m"),
        ("FLUX.1 Diffusion", 0.92, .sbbNeonMagenta, "1.8k req/m"),
        ("n8n Orchestration", 0.78, .sbbElectricBlue, "5.1k exec/m"),
        ("TV UHD Broadcast", 0.65, .sbbCrimsonLive, "60 FPS 4K"),
        ("AI Radio Playout", 0.70, .sbbActiveGreen, "192kbps DSP"),
        ("Vector Vault RAG", 0.88, .sbbElectricBlue, "12ms Latency")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Secondary Horizontal Tab Navigation
            HStack(spacing: 4) {
                ForEach(MatrixSubTab.allCases) { tab in
                    Button(action: {
                        selectedSubTab = tab
                    }) {
                        HStack(spacing: 6) {
                            if selectedSubTab == tab {
                                Rectangle()
                                    .fill(Color.sbbNeonCyan)
                                    .frame(width: 3, height: 12)
                            }
                            Text(tab.rawValue)
                                .font(.system(size: 12, weight: selectedSubTab == tab ? .semibold : .regular, design: .monospaced))
                                .foregroundColor(selectedSubTab == tab ? .white : .sbbTextSecondary)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(selectedSubTab == tab ? Color.sbbSurfaceElevated : Color.clear)
                        .cornerRadius(3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(selectedSubTab == tab ? Color.sbbBorder : Color.clear, lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
                
                // Telemetry summary chip
                HStack(spacing: 8) {
                    LivePulseDot(color: .sbbActiveGreen, size: 6)
                    Text("BARE-METAL CLUSTER: 100% HEALTHY")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.sbbActiveGreen)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.sbbSurfaceElevated)
                .cornerRadius(3)
                .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.sbbSurface)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.sbbBorder),
                alignment: .bottom
            )
            
            // Large Split-Pane Content Card
            ScrollView {
                VStack(spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        // Left Pane: Data Visualization & Bar Charts (Electric Blue & Magenta)
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "chart.bar.xaxis")
                                    .foregroundColor(.sbbNeonCyan)
                                Text("PIPELINE THROUGHPUT & LATENCY MATRIX")
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("LIVE // 24.00 FPS")
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sbbCrimsonLive)
                            }
                            
                            Divider().background(Color.sbbBorder)
                            
                            // High-Tech Bar Charts in Electric Blue & Neon Magenta
                            VStack(spacing: 14) {
                                ForEach(pipelineMetrics, id: \.name) { metric in
                                    VStack(alignment: .leading, spacing: 4) {
                                        HStack {
                                            Text(metric.name)
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundColor(.sbbTextPrimary)
                                            Spacer()
                                            Text(metric.count)
                                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                                .foregroundColor(metric.color)
                                        }
                                        
                                        GeometryReader { geo in
                                            ZStack(alignment: .leading) {
                                                // Background slot
                                                RoundedRectangle(cornerRadius: 2)
                                                    .fill(Color.sbbSurfaceElevated)
                                                    .frame(height: 8)
                                                
                                                // Active Bar
                                                RoundedRectangle(cornerRadius: 2)
                                                    .fill(
                                                        LinearGradient(
                                                            colors: [metric.color.opacity(0.7), metric.color],
                                                            startPoint: .leading,
                                                            endPoint: .trailing
                                                        )
                                                    )
                                                    .frame(width: geo.size.width * metric.value, height: 8)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 2)
                                                            .stroke(metric.color.opacity(0.8), lineWidth: 1)
                                                    )
                                            }
                                        }
                                        .frame(height: 8)
                                    }
                                }
                            }
                            
                            Divider().background(Color.sbbBorder)
                            
                            // Hardware Metrics Grid
                            HStack(spacing: 12) {
                                MetricCard(title: "TOTAL DISPATCHED", value: "142,890", subtitle: "Zero Drop Rate", color: .sbbNeonCyan)
                                MetricCard(title: "CLOUD EGRESS COST", value: "$0.00", subtitle: "100% Bare-Metal", color: .sbbActiveGreen)
                                MetricCard(title: "NEURAL LATENCY", value: "1.92s", subtitle: "FLUX.1 + Gemini", color: .sbbNeonMagenta)
                            }
                        }
                        .proCard(bg: .sbbSurface, border: .sbbBorder, radius: 3.0, padding: 16.0)
                        
                        // Right Pane: Autonomous Agent Workflows & Pipeline Visualizer
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Image(systemName: "point.3.connected.trianglepath.dotted")
                                    .foregroundColor(.sbbNeonMagenta)
                                Text("AUTONOMOUS AGENT ORCHESTRATION GRAPH")
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("ACTIVE PIPELINES: 6")
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sbbActiveGreen)
                            }
                            
                            Divider().background(Color.sbbBorder)
                            
                            // Visual Workflow Diagram (Geometric Nodes in Electric Blue and Magenta)
                            VStack(spacing: 12) {
                                WorkflowNodeRow(
                                    step: "01",
                                    title: "Script Intake & Semantic Ingestion",
                                    engine: "Gemini 3.6 Flash // JSON Structured",
                                    color: .sbbNeonCyan,
                                    port: "8815",
                                    icon: "doc.text.magnifyingglass"
                                )
                                
                                FlowConnectorView(color: .sbbNeonCyan)
                                
                                WorkflowNodeRow(
                                    step: "02",
                                    title: "Visual Framing & Multi-Tier Diffusion",
                                    engine: "FLUX.1 Neural Diffusion // 16:9 UHD",
                                    color: .sbbNeonMagenta,
                                    port: "8815",
                                    icon: "photo.stack.fill"
                                )
                                
                                FlowConnectorView(color: .sbbNeonMagenta)
                                
                                WorkflowNodeRow(
                                    step: "03",
                                    title: "Workflow Automation & Dispatch",
                                    engine: "n8n Embedded Engine // Webhook Nodes",
                                    color: .sbbElectricBlue,
                                    port: "5678",
                                    icon: "bolt.horizontal.circle.fill"
                                )
                                
                                FlowConnectorView(color: .sbbElectricBlue)
                                
                                WorkflowNodeRow(
                                    step: "04",
                                    title: "Broadcast Stages (TV Master & Radio FM)",
                                    engine: "Bare-Metal DSP & Canvas Renderers",
                                    color: .sbbCrimsonLive,
                                    port: "8812 / 8811",
                                    icon: "play.tv.fill"
                                )
                            }
                            
                            Divider().background(Color.sbbBorder)
                            
                            // Monospace Telemetry Terminal Stream
                            VStack(alignment: .leading, spacing: 4) {
                                Text("DAEMON LOG STREAM // STDOUT:")
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(.sbbTextSecondary)
                                
                                Text("[15:11:04] [INIT] FLUX.1 neural diffusion: Rendered 16:9 UHD (72.7KB)")
                                    .font(.system(size: 10, design: .monospaced))
                                    .foregroundColor(.sbbActiveGreen)
                                Text("[15:11:05] [n8n] Local webhook event triggered on port 5678")
                                    .font(.system(size: 10, design: .monospaced))
                                    .foregroundColor(.sbbNeonCyan)
                                Text("[15:11:06] [TV-UHD] 24FPS Master stream synchronized with audio DSP")
                                    .font(.system(size: 10, design: .monospaced))
                                    .foregroundColor(.sbbElectricBlue)
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.sbbBackground)
                            .cornerRadius(3)
                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                        }
                        .proCard(bg: .sbbSurface, border: .sbbBorder, radius: 3.0, padding: 16.0)
                    }
                }
                .padding(16)
            }
            .background(Color.sbbBackground)
        }
        .background(Color.sbbBackground)
    }
}

// MARK: - Metric Card Component
struct MetricCard: View {
    let title: String
    let value: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(.sbbTextSecondary)
            Text(value)
                .font(.system(size: 18, weight: .black, design: .monospaced))
                .foregroundColor(color)
            Text(subtitle)
                .font(.system(size: 9))
                .foregroundColor(.sbbTextMuted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.sbbSurfaceElevated)
        .cornerRadius(3)
        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
    }
}

// MARK: - Workflow Node Row
struct WorkflowNodeRow: View {
    let step: String
    let title: String
    let engine: String
    let color: Color
    let port: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 2)
                    .fill(color.opacity(0.15))
                    .frame(width: 32, height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(color.opacity(0.6), lineWidth: 1))
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 13, weight: .bold))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(title)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("PORT " + port)
                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                        .foregroundColor(color)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(color.opacity(0.12))
                        .cornerRadius(2)
                }
                Text(engine)
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(.sbbTextSecondary)
            }
        }
        .padding(10)
        .background(Color.sbbSurfaceElevated)
        .cornerRadius(3)
        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
    }
}

// MARK: - Flow Connector View
struct FlowConnectorView: View {
    let color: Color
    
    var body: some View {
        HStack {
            Spacer()
            Rectangle()
                .fill(color.opacity(0.5))
                .frame(width: 2, height: 10)
            Spacer()
        }
    }
}
