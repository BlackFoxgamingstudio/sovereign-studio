# Sovereign Studio (macOS Native Enterprise Mainframe)
**The Sovereign Glass Cockpit for Autonomous Enterprise Orchestration, Multi-Channel Broadcast Playout, Generative Visual Media, and Edge Telemetry**

[![Platform: macOS 14+ Sonoma / Sequoia](https://img.shields.io/badge/Platform-macOS%2014%2B%20Sonoma%20%2F%20Sequoia-000000?style=for-the-badge&logo=apple&logoColor=white)](https://apple.com)
[![Swift 6.0 Native](https://img.shields.io/badge/Swift-6.0%20Release-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://swift.org)
[![Architecture: Apple Silicon M-Series](https://img.shields.io/badge/Architecture-Apple%20Silicon%20ARM64-0071E3?style=for-the-badge&logo=apple&logoColor=white)](https://apple.com)
[![Embedded n8n Command Center](https://img.shields.io/badge/Orchestrator-n8n%20Node%2020%20Local-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)](https://n8n.io)
[![Cloud Egress: $0.00 / Mo](https://img.shields.io/badge/Cloud%20Egress-%240.00%20%2F%20Mo%20Bare--Metal-00C853?style=for-the-badge&logo=serverfault&logoColor=white)](https://github.com/BlackFoxgamingstudio/sovereign-studio)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](LICENSE)

---

## 1. Executive Summary & Architectural Manifesto

### 1.1 The Sovereign Imperative
Modern enterprise technology stacks are plagued by fragmentation, exorbitant SaaS recurring subscription fees, fragile multi-tenant cloud dependencies, and catastrophic data privacy risks. Standard corporate operations frequently rely on dozens of disjointed web portals—Zapier for automated gluing, Airtable for semi-structured record management, Frame.io for video dailies, Hootsuite for broadcast distribution, Datadog for telemetry, and proprietary CRM platforms—each leaking operational IP and compounding latency across third-party networks.

**Sovereign Studio** completely eliminates this paradigm. It is an industrial-grade, native macOS desktop application engineered in **Swift 6.0** and **SwiftUI** for Apple Silicon. Serving as the primary human-machine interface (HMI) and "glass cockpit" for the **Sovereign Biz Box (SBB)** bare-metal mainframe, Sovereign Studio centralizes autonomous AI multi-agent orchestration, broadcast television playout, 24/7 autonomous radio synthesis, generative cinematic storyboarding, and real-time edge telemetry into a unified, zero-latency desktop console.

### 1.2 The Local-First Multi-Engine Architecture
Rather than functioning as a lightweight browser wrapper or an Electron memory sink, Sovereign Studio is architectured as a multi-tier hybrid client-server ecosystem:
1. **Native macOS Host Layer (`SovereignStudio.app`)**: Built with Swift 6.0, AppKit, SwiftUI, and WebKit (`WKWebView`). It leverages macOS Sonoma/Sequoia native windowing, hardware-accelerated Metal compositing, low-overhead inter-process communication (IPC), and unified memory management.
2. **Embedded Zero-Trust Process Mesh**: Isolates distinct microservice web consoles within sandboxed, cookie-managed `WKWebView` instances. This allows complex reactive web platforms (such as the n8n Workflow Designer and the Storyboard AI Canvas) to run side-by-side with zero cross-origin taint.
3. **Local Microservices Cluster (Ports 8765–8825)**: Backed by 35 specialized microservices written in Python, FastAPI, TypeScript, C++, and Go, running locally on bare-metal hardware (e.g., Apple Mac Mini or Mac Studio server rack appliances).
4. **Desktop Bridge Daemon (`:8820`)**: A zero-dependency, ultra-fast Python IPC daemon (`backend/studio_bridge.py`) that monitors host ports, executes autonomous Git cloning and ingestion, scaffolds zero-trust webhook adapters, and dynamically registers community nodes with the local workflow database.
5. **Zero Cloud Egress Philosophy**: All audio signal manipulation, video frame composition, neural vector RAG searches, telemetry anomaly detection, and database transactions occur entirely within localhost (`127.0.0.1`). Cloud egress is strictly zero dollars per month ($0.00/Mo).

---

## 2. High-Level Glass Cockpit Topology

The following diagram illustrates the topological interaction between the native SwiftUI application container, the embedded WebKit views, the desktop bridge daemon, and the distributed 35-microservice bare-metal backend:

```
+===================================================================================================+
|                                    SOVEREIGN STUDIO (NATIVE MACOS)                                |
|                                   Swift 6.0 / SwiftUI / AppKit Host                               |
+===================================================================================================+
|  [Sidebar Navigation]  |  [Glass Cockpit Navigation & Control Bar]                                |
|  - Mainframe Matrix    |  - Breadcrumbs: MAINFRAME // MODULE                                      |
|  - n8n Command Center  |  - Active LLM Engine: Gemini 3.6 Flash / OpenAI DALL-E 3                 |
|  - Storyboard AI       |  - Quick Project Switcher & "+ New Project" Modal                        |
|  - TV Broadcast Stage  |  - Global Live Simulcast Status & Killswitch                             |
|  - AI Radio Station    |  - Hardware Telemetry: Active Daemons (6/6 Local) | Cloud Egress: $0.00 |
|  - Repo Importer       +--------------------------------------------------------------------------+
|                        |                                                                          |
|  [Hardware Telemetry]  |                               ACTIVE MODULE VIEW                         |
|  - CPU / GPU Load      |                                                                          |
|  - Unified RAM Vitals  |  (Dynamic Multi-Engine Workspace: Native SwiftUI & Hardware WebKit)      |
|  - Port Health Table   |                                                                          |
+========================+==========================================================================+
                                          |                     |
                  +-----------------------+                     +-----------------------+
                  |                                                                     |
                  v (IPC / HTTP REST / WebSockets)                                      v (WebKit Local Loopback)
+------------------------------------+                                +-------------------------------------+
|    STUDIO BRIDGE DAEMON (:8820)    |                                |    EMBEDDED BROWSER RUNTIMES        |
|  backend/studio_bridge.py          |                                |  - n8n Workflow Designer (:5678)    |
|  - Repository Ingestion & Cloner   |                                |  - Storyboard Studio UI (:8815)     |
|  - Zero-Trust Adapter Generator    |                                |  - TV Master Stage Player (:8812)   |
|  - SQLite DB Dynamic Provisioning  |                                |  - AI Radio Cyber-Console (:8811)   |
+------------------------------------+                                +-------------------------------------+
                  |                                                                     |
                  +-----------------------------------+---------------------------------+
                                                      |
                                                      v
+===================================================================================================+
|                        SOVEREIGN BARE-METAL MICROSERVICES CLUSTER (35 ENGINES)                    |
+===================================================================================================+
| [Broadcast Media & Streaming]       | [AI Personas, RAG & Agents]        | [Core Systems & Edge IoT]      |
| - TV Broadcast Station (:8812)      | - Avatar Agents SRE (:8785)        | - Mainframe FSM (:8765)        |
| - AI Radio Playout Engine (:8811)   | - GrantFlow Multi-Agent (:8781)    | - Swift Ecosystem (:8767)      |
| - Save the Cat! Storyboard (:8815)  | - Sales Agent RAG (:8802)          | - Codebase Vault AST (:8766)   |
| - Commercial AVoIP DMX (:8810)      | - BlackArmor Chat (:8804)          | - RPi Edge Telemetry (:8770)   |
+-------------------------------------+------------------------------------+--------------------------------+
| [DevOps, Meta & Tooling]            | [Industrial & Spatial Computing]   | [Security & Enterprise ERP]    |
| - Microservice Autopackager (:8797) | - Spatial 3D BIM (:8780)           | - ServiceTitan ERP (:8787)     |
| - Career Matcher NLP (:8796)        | - Spatial Apple LiDAR (:8803)      | - Wazuh SIEM SOC2 (:8808)      |
| - Patterns Bible Linter (:8794)     | - Unity Barn Digital Twin (:8809)  | - HouseWisper CRM (:8807)      |
| - AWS Data Lakehouse (:8801)        | - HVAC Thermodynamic Sim (:8782)   | - Executive BI Engine (:8790)  |
+===================================================================================================+
```

---

## 3. Core Functional Modules

Sovereign Studio organizes enterprise operations into six dedicated, high-performance tabs accessible from the persistent 260-pixel left sidebar:

### 3.1 Mainframe Matrix & Autonomous SRE Console
The **Mainframe Matrix** (`MainframeMatrixView.swift`) serves as the central mission control room for the entire Sovereign Biz Box infrastructure. It presents real-time telemetry across distributed autonomous agent workflows, data pipelines, system health states, and cloud egress cost metrics.

#### Key Architectural Capabilities:
- **Secondary Sub-Tab Navigation**:
  - `Data Pipelines`: Visualizes real-time throughput across ingestion channels (Gemini 3.6 Ingestion at 2.4k req/m, FLUX.1 Diffusion at 1.8k req/m, n8n Orchestration at 5.1k exec/m, TV UHD Broadcast at 60 FPS 4K, AI Radio Playout at 192kbps DSP, and Vector Vault RAG at 12ms latency).
  - `Autonomous Agent Workflows`: Direct oversight of multi-agent state machines (`SovereignSovereignMainframeAndEngine` on Port 8765), tracking active personas (SentinelSRE, Architect, Builder, Underwriter).
  - `Matrix Status`: Hardware cluster status displaying core load across all CPU threads, Unified RAM allocations, and thermal headroom.
  - `Cloud Egress Telemetry`: Continuous cost auditing verifying that third-party cloud API costs remain at zero, highlighting savings compared to equivalent AWS/GCP SaaS stacks.
- **Autonomous Incident Remediation**: Integrates directly with `SentinelSRE` (`solutions/avatar-agents`) to detect anomalies (such as disk memory spikes, pipeline backpressure, or dead letter queue accumulations) and trigger automated self-healing scripts without human intervention.

### 3.2 n8n Workflow Automation Command Center
The **n8n Command Center** tab provides a seamless, zero-latency embedded interface into the local **n8n Workflow Engine** (`http://127.0.0.1:5678`), running on Node 20 with customized security configurations.

#### Key Architectural Capabilities:
- **Embedded WebKit Isolation**: Implemented via `EmbeddedWebView.swift`, which configures a hardened `WKWebViewConfiguration` with isolated cookie storage, custom user agents, and disabled third-party tracking.
- **Security & Cookie Management**: Sovereign Studio automatically launches n8n with `N8N_SECURE_COOKIE=false` and strict localhost origin bindings, allowing full drag-and-drop workflow design directly within the native macOS window.
- **70 Pre-Configured Enterprise Workflows**: Full access to the pre-seeded library of enterprise workflows, including:
  - `00_central_event_bus.json`: The CNCF CloudEvents v1.0.2 event mesh.
  - `04_media_broadcast_and_audio_simulcast.json`: The master multimedia broadcast coordinator.
  - Granular solutions `PKG-001` through `PKG-035` providing deterministic webhooks and event listeners.
- **Compiled Community Nodes Palette**: Directly exposes all 35 compiled Sovereign TypeScript community nodes (`SovereignAiRadioStation`, `SovereignTvBroadcastStation`, `SovereignStoryboardAi`, etc.) in the n8n node picker canvas.

### 3.3 Save the Cat! Storyboard AI Studio
The **Storyboard AI Studio** tab embeds the cinematic pre-production and visualization suite running on Port 8815 (`http://127.0.0.1:8815`). Engineered around Blake Snyder's renowned 15-beat narrative structure (*Save the Cat!*), this module enables content creators to turn written scripts into fully paced, visually stunning film and television animatics.

#### Key Architectural Capabilities:
- **15-Beat Cinematic Structural Scaffolding**:
  - Automatically structures narratives across industry-standard beats: *Opening Image, Theme Stated, Set-up, Catalyst, Debate, Break into Two, B Story, Fun & Games, Midpoint, Bad Guys Close In, All Hope Is Lost, Dark Night of the Soul, Break into Three, Finale, Final Image*.
  - Calculates proportional sub-second duration for each beat based on uploaded master audio length.
- **Multi-Provider Neural Image Generation**:
  - Direct integration with OpenAI (`gpt-image-1` / DALL-E 3) and Google Gemini for 1792x1024 ultra-high-definition (UHD) widescreen 16:9 cinematic visuals.
  - Advanced prompt synthesis injecting photographic optics: focal length (e.g., 35mm anamorphic, 85mm portrait), lighting setups (Rembrandt, volumetric neon, golden hour), and film stocks (Kodak Vision3 500T).
- **Sub-Second Audio Synchronization**:
  - Audio waveform ingestion supporting master Logic Pro AIFF (`.aif`), uncompressed WAV, and browser-optimized AAC (`.m4a`).
  - Whisper speech recognition alignment mapping exact spoken phrases to visual beat transitions.
- **One-Click Timeline Synchronization**: Changes made in the Storyboard Inspector instantly update the underlying SQLite database (`database/sqlite.db`) and stream updates to the TV Broadcast Stage in real-time.

### 3.4 TV Broadcast Station & Visual CG Stage
The **TV Broadcast Station** (`TVControlRoomView.swift`) is an enterprise-grade virtual television control room and master control automation console running on Port 8812 (`http://127.0.0.1:8812`). It orchestrates live video playout, multi-camera switching, graphics character generation (CG), and instant master export.

#### Key Architectural Capabilities:
- **Live 16:9 Master Stage Monitor**:
  - Embeds the hardware-accelerated Stage Player (`/stage?project_id=...`) with 800ms Ken Burns pan-and-scan camera motions and seamless visual crossfading.
  - Powered by native HTTP 206 Partial Content byte-range audio streaming, supporting instant scrubbing, duration calculation, and zero playback buffering.
- **Real-Time Character Generator (CG) Ticker**:
  - Live news crawl generator with customizable crawl speeds, broadcast themes (Crimson Live `#FF3366`, Cyber Amber, Electric Blue), and dynamic breaking news injection.
  - Remote ticker updates via REST API or n8n event bus without interrupting live playout.
- **Multi-Camera Studio Switching Matrix**:
  - Switch between virtual studio camera angles in real time:
    - `CAM_01 (Wide Studio)`: Full panoramic perspective of virtual broadcast studio and anchor desk.
    - `CAM_02 (Anchor Closeup)`: Intimate teleprompter presentation framing.
    - `CAM_03 (Data Split Screen)`: Dual-pane layout pairing the virtual presenter with live market or telemetry data charts.
    - `CAM_04 (Presentation PiP Slide View)`: Fullscreen slide projection with picture-in-picture presenter overlay.
- **Soundtrack & Narration Upload**:
  - Drag-and-drop ingestion of Logic Pro master audio tracks (`.aif`, `.m4a`, `.mp3`).
  - Automatic transcode pipeline generating 320kbps AAC companions and recalculating project beat timing.
- **One-Click 1080p Master Video Export**:
  - Renders a broadcast-quality 1080p MP4 master video (H.264 video, AAC audio, 30 FPS) with composited HUD graphics, lower-third tickers, and synchronized narration.
  - Automatically delivers the rendered master to the user's `~/Downloads` folder and the local broadcast archive (`data/exports/`).

### 3.5 AI Radio Station & Cyber-Broadcast Playout Console
The **AI Radio Station** (`AIRadioDeskView.swift`) controls the autonomous 24/7 internet radio broadcast server running on Port 8811 (`http://127.0.0.1:8811`). Designed for continuous music streaming, corporate podcast syndication, and automated commercial insertion, it eliminates the need for human broadcast engineers.

#### Key Architectural Capabilities:
- **Cyber-Broadcast Playout Console (`/radio`)**:
  - Real-time Web Audio API `AnalyserNode` frequency visualizer providing a 64-band audio spectrum analyzer and live oscilloscope.
  - Comprehensive transport controls: Play/Pause, Next Track, Previous Track, Time Scrubbing, Volume, Mute, Loop, and Auto-Advance.
- **Multi-Category Audio Library**:
  - Categorized track filter pills enabling instant curation of:
    - `🎙️ Podcasts`: Long-form audio narratives (e.g., *Episode 1: The $599 Mainframe*, *The Sicilian Defense*).
    - `⚡ Commercials`: Promo spots and automated sponsor announcements (e.g., *Goodbye Zapier 80s Promo*).
    - `🎵 Songs & Stems`: Musical compositions, backing stems, and theme music.
- **DSP Voiceover Ducking Engine**:
  - Automated dynamic audio ducking applying a smooth -14 dB attenuation curve to background music during DJ voiceovers or spoken station idents.
  - Visual Ducking Meter in the UI providing real-time visual feedback of gain reduction in decibels.
- **24-Hour Daypart Rotation Schedule**:
  - Automatically adjusts broadcast tone and music genres across four distinct daily dayparts:
    - `Morning Drive (06:00 - 11:00)`: Upbeat electronic and tech news briefing.
    - `Midday Sprint (11:00 - 16:00)`: High-focus Lo-Fi study beats and workflow automation tips.
    - `Evening Code (16:00 - 23:00)`: Deep synthwave and architectural deep dives.
    - `Overnight Drones (23:00 - 06:00)`: Minimal ambient space drones and server room white noise.
- **Generative AI DJ Patter (`/api/v1/radio/generate-dj`)**:
  - Generates conversational DJ breaks on demand using local LLM prompts, introducing upcoming songs, reading weather/telemetry reports, and delivering station idents.

### 3.6 Repository Importer & Zero-Trust Packaging Bridge
The **Repo Importer** (`RepoImporterView.swift`) interfaces directly with the local **Studio Bridge Daemon** on Port 8820 (`backend/studio_bridge.py`). It enables developers and enterprise administrators to ingest any existing Git repository and instantly package it into a compliant Sovereign Biz Box microservice.

#### Key Architectural Capabilities:
- **Automated Repository Cloning**: Accepts a GitHub HTTPS/SSH URL, clones the codebase into `solutions/<repo-name>`, and analyzes the internal language composition (Python, TypeScript, Go, C++, Rust).
- **Zero-Trust Adapter Scaffolding**: Automatically generates a standards-compliant `n8n/webhook_adapter.py` providing:
  - Standardized health check probes (`GET /health`).
  - Idempotent action execution dispatchers (`POST /api/v1/execute`).
  - Automatic JSON event forwarding to the central event bus (`http://127.0.0.1:5678/webhook/event-bus`).
- **Dynamic Port Allocation**: Assigns an unused port in the 8765–8825 range and establishes a canonical environment variable (`SBB_<NAME>_URL`).
- **Automated Database & Workflow Provisioning**:
  - Generates a custom n8n workflow entity in `database.sqlite` linking an inbound webhook trigger directly to the microservice adapter.
  - Registers the new package in `databases/sbb_packaged_solutions.db` with `PRODUCTION_READY` certification status.

---

## 4. The Complete 35-Microservice Ecosystem

Sovereign Studio coordinates 35 specialized microservices across the Sovereign Biz Box bare-metal cluster. Each solution operates independently with its own Python virtual environment, deterministic port, custom n8n community node, and GitHub sub-repository:

| Package ID | Service Slug | Port | n8n Custom Community Node | Domain & Core Architectural Functionality |
| :--- | :--- | :--- | :--- | :--- |
| **PKG-001** | `raspberry-pi-telemetry-daemon` | `8770` | `SovereignRaspberryPiTelemetryDaemon` | Hardware sensor monitoring, sysfs thermal polling, and edge telemetry collection. |
| **PKG-002** | `spatial-bim` | `8780` | `SovereignSpatialBim` | Native C++ geometry parser extracting IFC/STEP building models and volumetric data. |
| **PKG-003** | `grantflow-rag` | `8781` | `SovereignGrantflowRag` | Multi-agent RAG engine for municipal, federal, and venture grant proposal drafting. |
| **PKG-004** | `hvac-thermo` | `8782` | `SovereignHvacThermo` | First-principles psychrometric calculations, enthalpy modeling, and diagnostic simulation. |
| **PKG-005** | `parts-compare` | `8783` | `SovereignPartsCompare` | E-commerce parts scraper, catalog normalization, and fuzzy string pricing matcher. |
| **PKG-006** | `cloud-architect` | `8784` | `SovereignCloudArchitect` | Infrastructure-as-code linting, Terraform validation, and cloud compliance auditing. |
| **PKG-007** | `avatar-agents` | `8785` | `SovereignAvatarAgents` | Autonomous SRE personas (`SentinelSRE`, `Architect`, `Builder`) with automated healing. |
| **PKG-008** | `godot-pipeline` | `8786` | `SovereignGodotPipeline` | Headless Godot 4.x asset packaging, sprite compiling, and multi-platform CI/CD. |
| **PKG-009** | `servicetitan-bridge` | `8787` | `SovereignServicetitanBridge` | Enterprise field service ERP webhook consumer and automated dispatch PDF compiler. |
| **PKG-010** | `rpa-auth-agent` | `8788` | `SovereignRpaAuthAgent` | Headless browser session orchestrator, cookie refresher, and automated portal worker. |
| **PKG-011** | `field-lms` | `8789` | `SovereignFieldLms` | Technical curriculum engine, interactive trade quizzes, and dynamic PDF certificates. |
| **PKG-012** | `executive-bi` | `8790` | `SovereignExecutiveBi` | Embedded PGlite WASM in-browser SQL analytics and executive KPI reporting engine. |
| **PKG-013** | `diagnostic-tree` | `8791` | `SovereignDiagnosticTree` | Deterministic expert system decision trees for field fault isolation and MTTR reduction. |
| **PKG-014** | `supervisor-dispatch` | `8792` | `SovereignSupervisorDispatch` | Real-time technician fleet tracking, GPS proximity dispatching, and job reordering. |
| **PKG-015** | `telemetry-reports` | `8793` | `SovereignTelemetryReports` | Automated compilation of industrial facility audit reports into PDF/CSV packages. |
| **PKG-016** | `patterns-bible` | `8794` | `SovereignPatternsBible` | AST static analysis linter enforcing GoF design patterns and architectural standards. |
| **PKG-017** | `venture-underwriting` | `8795` | `SovereignVentureUnderwriting` | Venture capital financial modeling, DCF valuations, and automated cap table dilution. |
| **PKG-018** | `career-matcher` | `8796` | `SovereignCareerMatcher` | Semantic vector resume parsing, ATS keyword scoring, and dynamic PDF tailoring. |
| **PKG-019** | `autopackager` | `8797` | `SovereignAutopackager` | Meta-engineering CLI converting raw developer scripts into modular microservices. |
| **PKG-020** | `codebase-vault` | `8766` | `SovereignCodebaseVault` | AST code indexer parsing 140,000+ files into a local SQLite architectural graph ledger. |
| **PKG-021** | `aws-dataeng` | `8801` | `SovereignAwsDataeng` | S3 batch ingestion, Parquet validation, and serverless Lakehouse ETL transformations. |
| **PKG-022** | `sales-agent-rag` | `8802` | `SovereignSalesAgentRag` | ChromaDB vector search providing sales objection battlecards and product pricing RAG. |
| **PKG-023** | `spatial-lidar` | `8803` | `SovereignSpatialLidar` | Apple ARKit LiDAR point-cloud processing, mesh extraction, and USDZ 3D export. |
| **PKG-024** | `blackarmor-chat` | `8804` | `SovereignBlackarmorChat` | End-to-end encrypted real-time WebSocket chat gateway with zero-telemetry persistence. |
| **PKG-025** | `smartpi-telemetry` | `8805` | `SovereignSmartpiTelemetry` | Industrial acoustic diagnostics and vibrational spectrum analysis via USB microphone. |
| **PKG-026** | `bizdev-engageos` | `8806` | `SovereignBizdevEngageos` | B2B cold email deliverability engine with SPF/DKIM verification and sequence automation. |
| **PKG-027** | `housewisper-crm` | `8807` | `SovereignHousewisperCrm` | Real estate PropTech automation engine syncing MLS listings and transaction milestones. |
| **PKG-028** | `wazuh-siem` | `8808` | `SovereignWazuhSiem` | Enterprise cybersecurity syslog listener, MITRE ATT&CK alerting, and SOC2 compliance. |
| **PKG-029** | `unity-barn-twin` | `8809` | `SovereignUnityBarnTwin` | Real-time 3D Unity digital twin synchronizing physical barn climate sensors over WebSockets. |
| **PKG-030** | `lotte-avoip` | `8810` | `SovereignLotteAvoip` | Commercial AV over IP and DMX/Art-Net UDP lighting controller for architectural venues. |
| **PKG-031** | `ai-radio-station` | `8811` | `SovereignAiRadioStation` | 24/7 autonomous internet radio stream, AI DJ generation, and DSP ducking mixer. |
| **PKG-032** | `tv-broadcast-station` | `8812` | `SovereignTvBroadcastStation` | Master television broadcast stage, lower-third CG ticker, and 1080p MP4 compiler. |
| **PKG-033** | `storyboard-ai` | `8815` / `8825` | `SovereignStoryboardAi` | Save the Cat! 15-beat narrative engine, 16:9 UHD visual diffusion, and audio timing sync. |
| **PKG-034** | `sovereign-mainframe-and-engine` | `8765` | `SovereignSovereignMainframeAndEngine` | Distributed agent state machine, consensus broker, and protocol FSM engine. |
| **PKG-035** | `swift-apple-ecosystem-suite` | `8767` | `SovereignSwiftAppleEcosystemSuite` | Native macOS menu bar daemon, SwiftData offline cache, and APNs push notification bridge. |

---

## 5. Technology Stack & Prerequisites

Sovereign Studio is built from the ground up for maximum performance and minimal system overhead on modern macOS workstations:

### 5.1 Host Application Stack
- **Language**: Swift 6.0 (Strict Concurrency Checking, Swift Modern Concurrency `async/await`).
- **UI Framework**: SwiftUI & AppKit hybrid (`NSApplication`, `NSWindow`, `NSSplitView`).
- **Web Rendering**: WebKit Framework (`WKWebView`, `WKWebViewConfiguration`, `WKPreferences`).
- **Target OS**: macOS 14.0 Sonoma or macOS 15.0 Sequoia.
- **Hardware Target**: Apple Silicon M-Series (M1, M1 Pro/Max/Ultra, M2, M3, M4). Universal Binary support available.

### 5.2 Microservice & Daemon Runtimes
- **Python Runtime**: Python 3.11+ or Python 3.14 (with `uvicorn`, `fastapi`, `pydantic`, `httpx`).
- **Orchestration Runtime**: Node.js v20.x or v22.x LTS (running `n8n` with task runners).
- **Media Transcoding**: `ffmpeg` 6.0+ with `libx264`, `aac`, and `scale` filters.
- **Database Engines**: SQLite 3.43+ with Write-Ahead Logging (`WAL` mode) enabled across all local state vaults.

---

## 6. Installation & Quick Start Guide

### 6.1 Clone the Workspace
To build and run Sovereign Studio, clone the repository to your local Apple Silicon workstation:

```bash
git clone https://github.com/BlackFoxgamingstudio/sovereign-studio.git
cd sovereign-studio
```

### 6.2 Launching the Complete Studio Environment
Sovereign Studio includes a comprehensive launch and packaging script: `run_sovereign_studio.sh`. This script handles daemon lifecycle management, compiles the native Swift binary, packages a self-contained macOS `.app` bundle, and launches the application.

Execute the launcher script:
```bash
./run_sovereign_studio.sh
```

#### What `run_sovereign_studio.sh` Does Under the Hood:
1. **Studio Bridge Probe**: Checks if the Desktop Bridge Daemon is running on Port 8820. If inactive, it spawns `backend/studio_bridge.py` in the background and writes telemetry to `backend/bridge.log`.
2. **n8n Command Center Probe**: Probes Port 5678. If inactive, it boots the local n8n workflow engine with `N8N_SECURE_COOKIE=false` and localhost bindings.
3. **Storyboard AI Probe**: Checks Port 8815. If inactive, it activates the Storyboard AI FastAPI backend using `uvicorn` and routes execution logs to `backend/storyboard.log`.
4. **Swift 6.0 Release Compilation**: Runs `swift build -c release` using Swift Package Manager to produce a highly optimized binary in `.build/release/SovereignStudio`.
5. **Application Bundle Assembly**:
   - Generates the standard macOS bundle hierarchy: `SovereignStudio.app/Contents/MacOS/` and `SovereignStudio.app/Contents/Resources/`.
   - Injects a production `Info.plist` configuring high-resolution Retina rendering, minimum system version (macOS 14.0), and App Transport Security (`NSAllowsArbitraryLoads = true`) for unhindered local HTTP loopback communication.
6. **Execution & Foregrounding**: Executes `open SovereignStudio.app`, bringing the glass cockpit directly to your screen with an active macOS Dock presence.

---

## 7. Deep Dive: Swift 6.0 Source Code Architecture

The native client source code is cleanly organized under `Sources/SovereignStudio/`:

### 7.1 `SovereignStudioApp.swift` (Application Lifecycle)
The entry point of the application conforms to the SwiftUI `App` protocol:
```swift
import SwiftUI

@main
struct SovereignStudioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        .commands {
            SidebarCommands()
            CommandGroup(replacing: .newItem) { }
        }
    }
}
```
- **Hidden Title Bar**: Leverages `.windowStyle(.hiddenTitleBar)` to maximize usable screen real estate, creating a sleek, dark-mode terminal aesthetic reminiscent of DaVinci Resolve or Final Cut Pro.
- **Custom Window Commands**: Integrates macOS-standard shortcut keys (`Cmd+\` to toggle sidebar, `Cmd+R` for rapid module reloading).

### 7.2 `ContentView.swift` (Master Glass Cockpit & Layout Engine)
Controls the top-level dual-column layout, module routing, and global telemetry:
- **`StudioTab` Enumeration**: Defines the primary tabs (`.matrix`, `.n8n`, `.storyboard`, `.tvControl`, `.aiRadio`, `.repoImporter`) with associated SF Symbols and neon brand accent colors (`sbbNeonCyan`, `sbbElectricBlue`, `sbbCrimsonLive`, `sbbActiveGreen`, `sbbNeonMagenta`).
- **Telemetry Footer**: Displays real-time status chips for the 6 local daemons and the `$0.00 / Mo` cloud egress audit badge.
- **Dynamic Header Bar**: Renders module breadcrumbs (`MAINFRAME // MODULE`), active AI models (`Gemini 3.6 Flash | OpenAI gpt-image-1`), the `+ New Project` action button, and the live simulcast indicator.

### 7.3 `EmbeddedWebView.swift` (Hardened WebKit Container)
Wraps Apple's AppKit `WKWebView` inside SwiftUI's `NSViewRepresentable`:
- **Cross-Origin & Mixed Content Allowance**: Configures WebKit preferences to permit local HTTP loopback communication without browser security warnings.
- **Reactive Reloading**: Binds to `@Binding var reloadTrigger: Bool` to force hard refreshes whenever background microservices redeploy or compile new assets.
- **Non-Persistent Cookie Store**: Keeps user sessions and auth tokens isolated to prevent credential leaking across embedded applications.

### 7.4 `TVControlRoomView.swift` (Virtual Television Master Control)
The visual control center for television broadcasts:
- **State Management**: Tracks active project IDs (`proj-chicago-chess-dream`, `proj-yt-ep01-599-mainframe`), live on-air status, selected camera angle (`CAM_01` through `CAM_04`), and lower-third crawl text.
- **Dynamic Viewport Switching**: Toggles between the embedded 16:9 Master Stage player (`/stage?project_id=...`) and the Studio Cameras overview grid.
- **Master Video Download Handler**: Implements asynchronous Blob streaming to download rendered 1080p MP4 files directly to the macOS user's `~/Downloads` directory without triggering sandboxed browser download rejections.

### 7.5 `AIRadioDeskView.swift` (Cyber-Broadcast Playout Console)
The audio command desk for autonomous radio operations:
- **Audio Radar Pulse**: Animated concentric radar circles visualizing real-time radio broadcast activity.
- **DSP Voice Ducking Gauge**: Displays the attenuation level applied to backing music when AI DJ commentary triggers.
- **Daypart Selector**: Interactive matrix allowing the operator to force or schedule radio dayparts (Morning Drive, Midday Sprint, Evening Code, Overnight Ambient).

### 7.6 `RepoImporterView.swift` (Meta-Engineering Ingestion)
The GUI interface for importing external codebases:
- Accepts a Git repository URL, name, and description.
- Dispatches asynchronous `POST` requests to the Studio Bridge on Port 8820.
- Displays live terminal logs showing clone progress, adapter scaffolding, port assignment, and n8n workflow generation.

### 7.7 `Theme.swift` (Cyberpunk High-Contrast Pro Design System)
Defines the sovereign color palette:
- `sbbBackground` (`#0A0D14`): Deep obsidian black background minimizing eye strain during long production sessions.
- `sbbSurface` (`#111622`): Elevated slate surface for navigation sidebars and headers.
- `sbbSurfaceElevated` (`#182030`): Raised panel background for cards, modals, and input fields.
- `sbbBorder` (`#222D42`): Subtle divider lines defining modular panes.
- `sbbNeonCyan` (`#00E5FF`): Primary brand color for system breadcrumbs, active states, and focus indicators.
- `sbbElectricBlue` (`#2979FF`): Secondary accent for workflow nodes and primary action buttons.
- `sbbCrimsonLive` (`#FF1744`): High-visibility broadcast crimson for live on-air indicators and record triggers.
- `sbbActiveGreen` (`#00E676`): Clean terminal green indicating healthy microservice daemons and zero cloud egress.
- `sbbWarningAmber` (`#FFD600`): Diagnostic amber for telemetry alerts and DSP voice ducking levels.

---

## 8. Deep Dive: Studio Bridge Daemon (`:8820`)

The **Studio Bridge** (`backend/studio_bridge.py`) is an asynchronous, zero-dependency Python HTTP server running on Port 8820. It serves as the local operating system interface for the SwiftUI client, translating high-level user actions into deterministic filesystem and database mutations.

### 8.1 API Specification & Endpoints

#### `GET /health` (System Vitals Probe)
Returns the operational health of the bridge daemon, the total number of registered solutions, and the active port map across the cluster.
- **Response `200 OK`**:
```json
{
  "status": "healthy",
  "service": "sovereign-studio-bridge",
  "port": 8820,
  "registered_solutions_count": 35,
  "active_ports": {
    "desktop_bridge": 8820,
    "storyboard_ai": 8815,
    "tv_broadcast": 8812,
    "ai_radio": 8811,
    "n8n_command_center": 5678,
    "sales_agent_rag": 8802,
    "swift_apple_suite": 8767
  }
}
```

#### `GET /api/v1/solutions` (Solution Inventory)
Scans `solutions/` and returns an array of all detected microservices, indicating whether each microservice possesses an active n8n webhook adapter.
- **Response `200 OK`**:
```json
{
  "count": 35,
  "solutions": [
    {
      "name": "ai-radio-station",
      "path": "/Users/russellpowers/Sovereign Biz Box/solutions/ai-radio-station",
      "has_adapter": true
    },
    {
      "name": "tv-broadcast-station",
      "path": "/Users/russellpowers/Sovereign Biz Box/solutions/tv-broadcast-station",
      "has_adapter": true
    }
  ]
}
```

#### `POST /api/v1/import` (Automated Repository Ingestion)
Clones an external Git repository, dynamically allocates a port, writes a standalone webhook adapter, and registers the service into n8n's SQLite database.
- **Request Headers**:
  - `Content-Type: application/json`
  - `X-SBB-Auth: sbb_local_dev_secret_2026`
- **Request Body**:
```json
{
  "repo_name": "iot-sensor-telemetry",
  "github_url": "https://github.com/ExampleOrg/iot-sensor-telemetry.git",
  "description": "Industrial IoT vibration and telemetry collector"
}
```
- **Execution Workflow**:
  1. Clones repository via `git clone` into `solutions/iot-sensor-telemetry`.
  2. Queries existing ports across `solutions/` and allocates the next available port (e.g., `8821`).
  3. Scaffolds `solutions/iot-sensor-telemetry/n8n/webhook_adapter.py`.
  4. Connects to `sbb-n8n-command-center/.n8n/.n8n/database.sqlite`.
  5. Inserts a new workflow entity into `workflow_entity` and links it in `shared_workflow`.
  6. Inserts the canonical URL variable `SBB_IOT_SENSOR_TELEMETRY_URL = http://127.0.0.1:8821` into the `variables` table.
  7. Updates `databases/sbb_packaged_solutions.db`.

#### `POST /api/v1/simulcast` (Master Broadcast Synchronization)
Coordinates a live multimedia simulcast across TV and Radio channels.
- **Request Body**:
```json
{
  "project_id": "proj-yt-ep01-599-mainframe",
  "action": "start_simulcast",
  "channels": ["tv_broadcast", "ai_radio"]
}
```
- **Execution Workflow**:
  - Pushes show rundown manifest to TV Broadcast Station (`:8812/api/v1/broadcast/deploy`).
  - Instructs AI Radio Station (`:8811/api/v1/radio/play`) to cue the master soundtrack with synchronized DJ introduction.

---

## 9. Audio & Video Playout Mechanics

### 9.1 Browser & WebView Audio Compatibility
Web browsers and Apple WebViews enforce strict audio decoding standards. Uncompressed PCM AIFF (`.aif`/`.aiff`) files generated by digital audio workstations (like Apple Logic Pro) are not natively playable within HTML5 `<audio>` tags in Chromium or WebKit.

Sovereign Studio resolves this through an automated media pipeline:
1. **Pristine Transcoding**: Whenever master audio (`.aif`) is uploaded or detected, the system automatically transcodes a 320kbps AAC companion (`.m4a`) and an MP3 companion (`.mp3`) using `ffmpeg`:
   ```bash
   ffmpeg -y -i "input.aif" -c:a aac -b:a 320k -movflags +faststart "output.m4a"
   ```
2. **HTTP 206 Partial Content (Byte-Range Streaming)**: Both the TV Broadcast Station (`:8812`) and AI Radio Station (`:8811`) implement HTTP 206 byte-range handling. When WebKit requests audio chunks (`Range: bytes=0-`), the servers respond with:
   - `HTTP/1.1 206 Partial Content`
   - `Content-Range: bytes 0-1048575/18123456`
   - `Accept-Ranges: bytes`
   This allows the web players to instantly calculate duration (`loadedmetadata`), enable instant scrub seeks, and avoid waiting for multi-gigabyte audio tracks to download.
3. **Autoplay Policy Unlock**: Sovereign Studio embeds click-to-play unlock handlers in `stage_player.html` and `radio_player.html` to guarantee that audio plays immediately when the user clicks **Play** or changes tabs.

---

## 10. Verification, Testing & Quality Assurance

Sovereign Studio includes a comprehensive unit and integration testing suite verifying both Swift UI components and Python backend daemons.

### 10.1 Running Swift Native Unit Tests
Execute the Swift package test runner:
```bash
swift test
```
The test runner validates:
- Model serialization and deserialization (`Models.swift`).
- Theme color conformance and hex string parsing (`Theme.swift`).
- Port availability and network configuration constants.

### 10.2 Verifying Microservice Health
You can execute automated curl checks across all core daemons:
```bash
# Check Storyboard AI Backend
curl -s http://127.0.0.1:8815/health | jq .

# Check TV Broadcast Station Master Control
curl -s http://127.0.0.1:8812/health | jq .

# Check AI Radio Station Playout Server
curl -s http://127.0.0.1:8811/health | jq .

# Check Desktop Bridge Daemon
curl -s http://127.0.0.1:8820/health | jq .

# Check n8n Workflow Engine
curl -s -I http://127.0.0.1:5678 | head -n 5
```

### 10.3 Knowledge Base Audit
All architectural decisions, bug fixes, and engineering patterns are permanently logged in the SQLite knowledge vault: `databases/sbb_learning_and_growth.db`. You can query recent solutions using Python:
```bash
python3 -c "
import sqlite3
conn = sqlite3.connect('databases/sbb_learning_and_growth.db')
c = conn.cursor()
c.execute('SELECT id, category, tags FROM engineering_knowledge_base ORDER BY id DESC LIMIT 3')
for row in c.fetchall():
    print(row)
"
```

---

## 11. Troubleshooting & Diagnostics

### 11.1 Port Conflicts & Stale Processes
If a daemon fails to bind to its assigned port upon startup, inspect active listening processes:
```bash
# Check what is holding Port 8815, 8812, 8811, or 8820
lsof -i :8815 -i :8812 -i :8811 -i :8820
```
To terminate a stale daemon:
```bash
kill -9 <PID>
```

### 11.2 n8n Embedded WebView Displays White Screen
If the n8n Command Center tab renders a blank screen inside Sovereign Studio:
1. Ensure n8n was launched with `N8N_SECURE_COOKIE=false`. When running over localhost HTTP inside an embedded `WKWebView`, secure cookies are blocked by WebKit security policies.
2. Force reload the tab using the **Quick Reload** button (`Cmd+R` or the circular arrow in the top header).
3. Check `sbb-n8n-command-center/.n8n/.n8n/n8nEventLog*.log` for database migration locks.

### 11.3 Video Playout Has No Audio on Stage Monitor
1. Verify that companion `.m4a` files exist alongside `.aif` tracks in `solutions/tv-broadcast-station/data/audio/`.
2. Inspect the TV station adapter log to ensure HTTP 206 Partial Content responses are being served.
3. Click anywhere on the 16:9 stage player to satisfy macOS WebKit user gesture autoplay requirements.

---

## 12. Security, Privacy & Compliance

Sovereign Studio adheres to strict zero-trust operational security guidelines:
- **Loopback Enforcement**: All network daemons bind exclusively to `127.0.0.1` or `localhost`. External network interfaces (`0.0.0.0`) are disabled by default unless explicitly routed through an authenticated reverse proxy.
- **Header-Based Authentication**: Inter-service POST endpoints require the `X-SBB-Auth` token header, matching `SBB_SHARED_SECRET`.
- **Zero Cloud Telemetry**: No user actions, telemetry vitals, audio transcripts, or generated artwork are ever dispatched to third-party tracking services or analytics servers.
- **SOC2 & SIEM Ready**: All platform actions emit structured audit events to `solutions/codebase-vault` (`:8766`) and `solutions/wazuh-siem` (`:8808`) for immutable compliance logging.

---

## 13. Roadmap & Future Milestones

- **Version 2.6 (Q4 2026)**:
  - Native Metal GPU accelerated rendering for 4K 60FPS video playout directly inside SwiftUI without WebKit canvas overhead.
  - CoreAudio low-latency DSP voiceover ducking audio driver for direct USB microphone broadcasting.
- **Version 3.0 (2027)**:
  - Apple Vision Pro native spatial computing companion app, streaming 3D LiDAR point clouds and virtual TV broadcast studio monitors into visionOS.
  - Distributed multi-Mac clustering, allowing multiple Apple Silicon machines to share model inference loads over Thunderbolt 5 networking.

---

## 14. Authors & License

**Sovereign Studio** is designed, architected, and maintained by **Russell Alan Powers** and **Black Fox Gaming Studio**.

- **Organization**: Black Fox Gaming Studio
- **Lead Architect**: Russell Alan Powers (<russell@blackfoxgaming.com>)
- **Repository**: [https://github.com/BlackFoxgamingstudio/sovereign-studio](https://github.com/BlackFoxgamingstudio/sovereign-studio)
- **License**: MIT License (See `LICENSE` file for full terms).

Copyright © 2026 Black Fox Gaming Studio & Russell Powers. All rights reserved.
