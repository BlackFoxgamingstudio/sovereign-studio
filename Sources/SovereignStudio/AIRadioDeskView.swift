import SwiftUI

struct AIRadioDeskView: View {
    @State private var currentShow = "Midday Autonomous Pulse"
    @State private var currentDJ = "DJ Sovereign"
    @State private var currentGenre = "LOFI_STUDY"
    @State private var isPlaying = true
    @State private var duckingGainDb: Double = -14.0
    @State private var radarPulse = false
    @State private var selectedDaypart = "MIDDAY_SPRINT"
    
    let dayparts = [
        ("MORNING_DRIVE", "Morning Drive (6-11)", "TECH_UPBEAT"),
        ("MIDDAY_SPRINT", "Midday Pulse (11-16)", "LOFI_STUDY"),
        ("EVENING_CODE", "Evening Deep Build (16-23)", "CHILL_SYNTH"),
        ("OVERNIGHT", "Bare-Metal Ambient (23-6)", "AMBIENT_SPACE")
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "radio.fill")
                        .foregroundColor(.green)
                    Text("W-SBB Radio 104.2 FM — Autonomous Playout Mixer")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Port: 8811 | DSP Ducking: -14dB")
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundColor(.green)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.12))
                    .cornerRadius(4)
            }
            .padding(12)
            .background(Color(nsColor: .windowBackgroundColor).opacity(0.9))
            
            Divider()
            
            HStack(spacing: 24) {
                // Left: Radar Visualizer
                VStack(spacing: 20) {
                    ZStack {
                        Circle()
                            .stroke(Color.purple.opacity(0.2), lineWidth: 2)
                            .frame(width: 200, height: 200)
                        
                        Circle()
                            .stroke(Color.purple.opacity(radarPulse ? 0.8 : 0.3), lineWidth: 2)
                            .frame(width: radarPulse ? 160 : 110, height: radarPulse ? 160 : 110)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: radarPulse)
                        
                        Circle()
                            .fill(Color(red: 0.15, green: 0.10, blue: 0.25))
                            .frame(width: 90, height: 90)
                        
                        VStack(spacing: 4) {
                            Image(systemName: "waveform")
                                .font(.system(size: 24))
                                .foregroundColor(.purple)
                            Text("104.2 FM")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 220)
                    .onAppear {
                        radarPulse = true
                    }
                    
                    VStack(spacing: 4) {
                        Text(currentShow)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                        Text("Host: " + currentDJ + " | Genre: " + currentGenre)
                            .font(.system(size: 11, design: .monospaced))
                            .foregroundColor(.purple)
                    }
                    
                    // DSP Voice Ducking Telemetry
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("DSP VOICE DUCKING:")
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "%.1f dB", duckingGainDb))
                                .font(.system(size: 11, weight: .bold, design: .monospaced))
                                .foregroundColor(.yellow)
                        }
                        
                        GeometryReader { g in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.yellow, .red], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: g.size.width * 0.72)
                            }
                        }
                        .frame(height: 8)
                        
                        Text("Attack: 250ms | Release: 600ms | Codec: AAC 320kbps")
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.gray)
                    }
                    .padding(14)
                    .background(Color(red: 0.10, green: 0.10, blue: 0.15))
                    .cornerRadius(8)
                    
                    Spacer()
                }
                .frame(width: 300)
                
                // Right: Dayparts & Live Timeline
                VStack(alignment: .leading, spacing: 16) {
                    Text("24-HOUR BROADCAST DAYPART SCHEDULE")
                        .font(.system(size: 13, weight: .bold, design: .monospaced))
                        .foregroundColor(.cyan)
                    
                    VStack(spacing: 8) {
                        ForEach(dayparts, id: \.0) { dp in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(dp.1)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(selectedDaypart == dp.0 ? .white : .primary)
                                    Text("Style: " + dp.2)
                                        .font(.system(size: 11, design: .monospaced))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if selectedDaypart == dp.0 {
                                    Text("ON AIR")
                                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                                        .foregroundColor(.green)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color.green.opacity(0.2))
                                        .cornerRadius(4)
                                }
                            }
                            .padding(10)
                            .background(selectedDaypart == dp.0 ? Color.purple.opacity(0.3) : Color(nsColor: .controlBackgroundColor))
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedDaypart = dp.0
                                currentGenre = dp.2
                            }
                        }
                    }
                    
                    Text("LIVE MIX TIMELINE:")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 6) {
                        TimelineItemView(time: "00:00 - 00:25", title: "Lo-Fi Focus Beat (Intro Bed)", type: "MUSIC_BED", color: .blue)
                        TimelineItemView(time: "00:25 - 01:05", title: "DJ Spoken Voice (AI Voice Automation)", type: "VOICE_TRACK", color: .yellow)
                        TimelineItemView(time: "01:05 - 01:10", title: "W-SBB Radio Legal Station Ident", type: "STATION_IDENT", color: .purple)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        triggerRadioHour()
                    }) {
                        HStack {
                            Image(systemName: "music.note.list")
                            Text("Generate & Assemble Broadcast Hour")
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(20)
        }
    }
    
    private func triggerRadioHour() {
        guard let url = URL(string: "http://127.0.0.1:8811/api/v1/execute") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("sbb_local_dev_secret_2026", forHTTPHeaderField: "X-SBB-Auth")
        let payload: [String: Any] = [
            "action": "assemble_broadcast_hour",
            "topic": "Sovereign Studio Desktop",
            "music_style": currentGenre
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        URLSession.shared.dataTask(with: request).resume()
    }
}

struct TimelineItemView: View {
    let time: String
    let title: String
    let type: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Text(time)
                .font(.system(size: 11, design: .monospaced))
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Text(type)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(color)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(color.opacity(0.15))
                .cornerRadius(4)
        }
        .padding(8)
        .background(Color(red: 0.11, green: 0.13, blue: 0.18))
        .cornerRadius(6)
    }
}
