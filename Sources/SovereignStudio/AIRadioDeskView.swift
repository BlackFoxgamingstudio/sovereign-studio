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
                    LivePulseDot(color: .sbbActiveGreen, size: 7)
                    Text("W-SBB Radio 104.2 FM — Autonomous Playout Mixer")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("PORT: 8811  |  DSP DUCKING: -14dB  |  AAC 320kbps")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(.sbbActiveGreen)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.sbbSurfaceElevated)
                    .cornerRadius(3)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.sbbSurface)
            .overlay(Rectangle().frame(height: 1).foregroundColor(Color.sbbBorder), alignment: .bottom)
            
            HStack(spacing: 16) {
                // Left: Radar Visualizer
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .stroke(Color.sbbNeonMagenta.opacity(0.2), lineWidth: 2)
                            .frame(width: 190, height: 190)
                        
                        Circle()
                            .stroke(Color.sbbNeonMagenta.opacity(radarPulse ? 0.8 : 0.3), lineWidth: 2)
                            .frame(width: radarPulse ? 160 : 110, height: radarPulse ? 160 : 110)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: radarPulse)
                        
                        Circle()
                            .fill(Color.sbbSurfaceElevated)
                            .frame(width: 85, height: 85)
                            .overlay(Circle().stroke(Color.sbbNeonMagenta.opacity(0.6), lineWidth: 1))
                        
                        VStack(spacing: 4) {
                            Image(systemName: "waveform")
                                .font(.system(size: 22))
                                .foregroundColor(.sbbNeonMagenta)
                            Text("104.2 FM")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 200)
                    .onAppear {
                        radarPulse = true
                    }
                    
                    VStack(spacing: 3) {
                        Text(currentShow)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                        Text("Host: " + currentDJ + " | Genre: " + currentGenre)
                            .font(.system(size: 10, design: .monospaced))
                            .foregroundColor(.sbbNeonCyan)
                    }
                    
                    // DSP Voice Ducking Telemetry
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("DSP VOICE DUCKING:")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.sbbTextSecondary)
                            Spacer()
                            Text(String(format: "%.1f dB", duckingGainDb))
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(.sbbWarningAmber)
                        }
                        
                        GeometryReader { g in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color.sbbSurfaceElevated)
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(LinearGradient(colors: [.sbbNeonCyan, .sbbNeonMagenta], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: g.size.width * 0.72)
                            }
                        }
                        .frame(height: 6)
                        
                        Text("Attack: 250ms | Release: 600ms | Hardware Bare-Metal DSP")
                            .font(.system(size: 9, design: .monospaced))
                            .foregroundColor(.sbbTextMuted)
                    }
                    .padding(12)
                    .background(Color.sbbSurfaceElevated)
                    .cornerRadius(3)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
                    
                    Spacer()
                }
                .frame(width: 290)
                .proCard(bg: .sbbSurface, border: .sbbBorder, radius: 3.0, padding: 16.0)
                
                // Right: Dayparts & Live Timeline
                VStack(alignment: .leading, spacing: 14) {
                    Text("24-HOUR BROADCAST DAYPART SCHEDULE")
                        .font(.system(size: 11, weight: .bold, design: .monospaced))
                        .foregroundColor(.sbbNeonCyan)
                    
                    VStack(spacing: 6) {
                        ForEach(dayparts, id: \.0) { dp in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(dp.1)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(selectedDaypart == dp.0 ? .white : .sbbTextSecondary)
                                    Text("Style: " + dp.2)
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundColor(.sbbTextMuted)
                                }
                                Spacer()
                                if selectedDaypart == dp.0 {
                                    Text("ON AIR")
                                        .font(.system(size: 9, weight: .bold, design: .monospaced))
                                        .foregroundColor(.sbbActiveGreen)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Color.sbbActiveGreen.opacity(0.15))
                                        .cornerRadius(2)
                                        .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.sbbActiveGreen.opacity(0.4), lineWidth: 1))
                                }
                            }
                            .padding(10)
                            .background(selectedDaypart == dp.0 ? Color.sbbSurfaceElevated : Color.sbbSurfaceElevated.opacity(0.4))
                            .cornerRadius(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 3)
                                    .stroke(selectedDaypart == dp.0 ? Color.sbbNeonMagenta : Color.sbbBorder, lineWidth: 1)
                            )
                            .onTapGesture {
                                selectedDaypart = dp.0
                                currentGenre = dp.2
                            }
                        }
                    }
                    
                    Text("LIVE MIX TIMELINE:")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.sbbTextSecondary)
                    
                    VStack(spacing: 6) {
                        TimelineItemView(time: "00:00 - 00:25", title: "Lo-Fi Focus Beat (Intro Bed)", type: "MUSIC_BED", color: .sbbNeonCyan)
                        TimelineItemView(time: "00:25 - 01:05", title: "DJ Spoken Voice (AI Automation)", type: "VOICE_TRACK", color: .sbbWarningAmber)
                        TimelineItemView(time: "01:05 - 01:10", title: "W-SBB Radio Legal Station Ident", type: "STATION_IDENT", color: .sbbNeonMagenta)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        triggerRadioHour()
                    }) {
                        HStack {
                            Image(systemName: "music.note.list")
                            Text("Generate & Assemble Broadcast Hour")
                        }
                        .font(.system(size: 12, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .background(Color.sbbElectricBlue)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                    }
                    .buttonStyle(.plain)
                }
                .proCard(bg: .sbbSurface, border: .sbbBorder, radius: 3.0, padding: 16.0)
            }
            .padding(16)
        }
        .background(Color.sbbBackground)
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
                .font(.system(size: 10, design: .monospaced))
                .foregroundColor(.sbbTextMuted)
                .frame(width: 85, alignment: .leading)
            Text(title)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.white)
            Spacer()
            Text(type)
                .font(.system(size: 9, weight: .bold, design: .monospaced))
                .foregroundColor(color)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(color.opacity(0.12))
                .cornerRadius(2)
                .overlay(RoundedRectangle(cornerRadius: 2).stroke(color.opacity(0.4), lineWidth: 1))
        }
        .padding(8)
        .background(Color.sbbSurfaceElevated)
        .cornerRadius(3)
        .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.sbbBorder, lineWidth: 1))
    }
}
