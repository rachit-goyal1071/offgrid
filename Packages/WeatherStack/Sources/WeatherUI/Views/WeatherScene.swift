import SwiftUI
import WeatherCore

struct WeatherScene: View {
    let kind: WeatherSceneKind
    let isDay: Bool
    
    var body: some View {
        ZStack {
            switch kind {
            case .clear, .partlyCloudy :
                if isDay {
                    SunView()
                } else {
                    MoonView()
                    StarField()
                }
            default:
                EmptyView()
            }
            
            // cloud layer
            if shouldShowClouds {
                CloudLayer(density: cloudDensity, dark: !isDay)
            }
            
            // Precipitation Layer
            switch kind {
            case .rain, .storm:
                RainLayer(intensity: kind == .storm ? 1.5 : 1.0)
            case .snow:
                SnowLayer()
            default:
                EmptyView()
            
            }
            
            // Lightning
            if kind == .storm {
                LightningOverlay()
            }
            
            // Fog
            if kind == .fog {
                FogOverlay()
            }
        }
        .allowsHitTesting(false)
    }
    
    private var shouldShowClouds: Bool {
        switch kind {
        case .cloudy, .partlyCloudy, .fog, .rain, .snow, .storm: return true
        case .clear: return false
        }
    }
    
    private var cloudDensity: CloudLayer.Density {
        switch kind {
        case .cloudy, .fog, .storm: return .dense
        default: return .sparse
        }
    }
}

struct SunView: View {
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            let rotation = (t * 8).truncatingRemainder(dividingBy: 360)
            
            ZStack {
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.yellow.opacity(0.5),
                                Color.orange.opacity(0.25),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 30,
                            endRadius: 120
                        )
                    )
                    .frame(width: 240, height: 240)
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color(red: 1.0, green: 0.97, blue: 0.78),
                                Color(red: 1.0, green: 0.84, blue: 0.42),
                                Color(red: 1.0, green: 0.71, blue: 0.29)
                            ],
                            center: UnitPoint(x: 0.35, y: 0.35),
                            startRadius: 5,
                            endRadius: 70
                        )
                    )
                    .frame(width: 110, height: 110)
                
                ForEach(0..<12, id: \.self) { i in
                    Capsule()
                        .fill(.yellow.opacity(0.35))
                        .frame(width: 3, height: 14)
                        .offset(y: -76)
                        .rotationEffect(.degrees(Double(i) * 30 + rotation))
                }
            }
            .offset(x: 90, y: -180)
        }
    }
}

struct MoonView: View {
    var body: some View {
        ZStack {
            // Glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.white.opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 30,
                        endRadius: 80
                    )
                )
                .frame(width: 160, height: 160)
            
            // Moon disc
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(red: 0.99, green: 0.97, blue: 0.89),
                            Color(red: 0.90, green: 0.87, blue: 0.76)
                        ],
                        center: UnitPoint(x: 0.35, y: 0.35),
                        startRadius: 5,
                        endRadius: 50
                    )
                )
                .frame(width: 90, height: 90)
            
            // Craters
            Group {
                Circle().fill(.black.opacity(0.08)).frame(width: 12, height: 12)
                    .offset(x: -15, y: -8)
                Circle().fill(.black.opacity(0.06)).frame(width: 8, height: 8)
                    .offset(x: 18, y: 5)
                Circle().fill(.black.opacity(0.05)).frame(width: 6, height: 6)
                    .offset(x: 5, y: 22)
            }
        }
        .offset(x: 90, y: -180)
    }
}

struct StarField: View {
    // Generate star positions once — recomputing each render would make them dance.
    private let stars: [Star] = (0..<60).map { _ in
        Star(
            x: Double.random(in: 0...1),
            y: Double.random(in: 0...0.55),
            size: Double.random(in: 1...2.8),
            twinkleDuration: Double.random(in: 2...5),
            twinkleDelay: Double.random(in: 0...5)
        )
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            
            GeometryReader { geo in
                ZStack {
                    ForEach(stars) { star in
                        let phase = (t / star.twinkleDuration + star.twinkleDelay)
                            .truncatingRemainder(dividingBy: 1)
                        let opacity = 0.3 + 0.7 * (0.5 + 0.5 * sin(phase * 2 * .pi))
                        
                        Circle()
                            .fill(.white)
                            .frame(width: star.size, height: star.size)
                            .shadow(color: .white.opacity(0.8), radius: 1.5)
                            .opacity(opacity)
                            .position(
                                x: star.x * geo.size.width,
                                y: star.y * geo.size.height
                            )
                    }
                }
            }
        }
    }
    
    struct Star: Identifiable {
        let id = UUID()
        let x: Double
        let y: Double
        let size: Double
        let twinkleDuration: Double
        let twinkleDelay: Double
    }
}

struct CloudLayer: View {
    enum Density { case sparse, dense }
    let density: Density
    let dark: Bool
    
    private let clouds: [Cloud]
    
    init(density: Density, dark: Bool) {
        self.density = density
        self.dark = dark
        
        let configs: [(x: Double, y: Double, scale: Double, opacity: Double, speed: Double)] = density == .dense ? [
            (x: -0.1, y: 0.08, scale: 1.6, opacity: 0.85, speed: 60),
            (x: 0.3,  y: 0.18, scale: 2.0, opacity: 0.75, speed: 80),
            (x: 0.6,  y: 0.12, scale: 1.4, opacity: 0.90, speed: 50),
            (x: -0.05,y: 0.28, scale: 1.7, opacity: 0.70, speed: 70),
            (x: 0.45, y: 0.32, scale: 1.5, opacity: 0.65, speed: 65)
        ] : [
            (x: 0.0,  y: 0.14, scale: 1.2, opacity: 0.85, speed: 70),
            (x: 0.55, y: 0.22, scale: 1.0, opacity: 0.70, speed: 60)
        ]
        
        self.clouds = configs.enumerated().map { index, config in
            Cloud(
                id: index,
                startX: config.x,
                y: config.y,
                scale: config.scale,
                opacity: config.opacity,
                speed: config.speed
            )
        }
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            
            Canvas { ctx, size in
                for cloud in clouds {
                    // Drift right-to-left, wrapping around the screen
                    let totalDistance = size.width + 300  // start offscreen left, end offscreen right
                    let progress = ((t / cloud.speed) + Double(cloud.id) * 0.3)
                        .truncatingRemainder(dividingBy: 1.0)
                    let x = cloud.startX * size.width + progress * totalDistance - 150
                    let wrappedX = x.truncatingRemainder(dividingBy: size.width + 300) - 150
                    let y = cloud.y * size.height
                    
                    drawCloud(
                        ctx: ctx,
                        at: CGPoint(x: wrappedX, y: y),
                        scale: cloud.scale,
                        opacity: cloud.opacity
                    )
                }
            }
        }
    }
    
    private func drawCloud(ctx: GraphicsContext, at point: CGPoint, scale: Double, opacity: Double) {
        let baseColor: Color = dark
            ? Color(red: 0.24, green: 0.26, blue: 0.32)
            : .white
        let color = baseColor.opacity(opacity)
        
        // A cloud is just four overlapping ellipses
        let ellipses: [(dx: Double, dy: Double, w: Double, h: Double)] = [
            (-40, 8,  56, 36),
            (-10, -8, 64, 48),
            (25,  -2, 56, 40),
            (50,  6,  44, 32)
        ]
        
        for e in ellipses {
            let rect = CGRect(
                x: point.x + e.dx * scale,
                y: point.y + e.dy * scale,
                width: e.w * scale,
                height: e.h * scale
            )
            ctx.fill(Path(ellipseIn: rect), with: .color(color))
        }
    }
    
    struct Cloud: Identifiable {
        let id: Int
        let startX: Double
        let y: Double
        let scale: Double
        let opacity: Double
        let speed: Double  // seconds for one full drift
    }
}

struct RainLayer: View {
    let intensity: Double  // 1.0 = normal, 1.5 = storm
    
    private let drops: [Raindrop]
    
    init(intensity: Double) {
        self.intensity = intensity
        let count = Int(80 * intensity)
        self.drops = (0..<count).map { _ in
            Raindrop(
                x: Double.random(in: 0...1),
                length: Double.random(in: 12...22),
                duration: Double.random(in: 0.6...1.2),
                delay: Double.random(in: 0...1.2),
                opacity: Double.random(in: 0.35...0.75)
            )
        }
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            
            Canvas { ctx, size in
                for drop in drops {
                    let cycle = ((t + drop.delay) / drop.duration)
                        .truncatingRemainder(dividingBy: 1.0)
                    let y = -30 + cycle * (size.height + 60)
                    let x = drop.x * size.width - cycle * 6  // slight slant
                    
                    let path = Path { p in
                        p.move(to: CGPoint(x: x, y: y))
                        p.addLine(to: CGPoint(x: x - 1, y: y + drop.length))
                    }
                    ctx.stroke(
                        path,
                        with: .color(Color(red: 0.74, green: 0.83, blue: 0.93).opacity(drop.opacity)),
                        lineWidth: 1.2
                    )
                }
            }
        }
    }
    
    struct Raindrop {
        let x: Double
        let length: Double
        let duration: Double
        let delay: Double
        let opacity: Double
    }
}

struct SnowLayer: View {
    private let flakes: [Snowflake] = (0..<50).map { _ in
        Snowflake(
            x: Double.random(in: 0...1),
            size: Double.random(in: 2...6),
            duration: Double.random(in: 6...14),
            delay: Double.random(in: 0...10),
            swayAmount: Double.random(in: 20...60),
            swayFrequency: Double.random(in: 0.5...1.5)
        )
    }
    
    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            
            Canvas { ctx, size in
                for flake in flakes {
                    let cycle = ((t + flake.delay) / flake.duration)
                        .truncatingRemainder(dividingBy: 1.0)
                    let baseY = -20 + cycle * (size.height + 40)
                    let sway = sin(cycle * 2 * .pi * flake.swayFrequency) * flake.swayAmount
                    let x = flake.x * size.width + sway
                    
                    let rect = CGRect(
                        x: x - flake.size / 2,
                        y: baseY - flake.size / 2,
                        width: flake.size,
                        height: flake.size
                    )
                    ctx.fill(
                        Path(ellipseIn: rect),
                        with: .color(.white.opacity(0.85))
                    )
                }
            }
        }
    }
    
    struct Snowflake {
        let x: Double
        let size: Double
        let duration: Double
        let delay: Double
        let swayAmount: Double
        let swayFrequency: Double
    }
}

struct LightningOverlay: View {
    @State private var flashOpacity: Double = 0
    
    var body: some View {
        Color.white
            .opacity(flashOpacity)
            .ignoresSafeArea()
            .allowsHitTesting(false)
            .onAppear {
                scheduleNextFlash()
            }
    }
    
    private func scheduleNextFlash() {
        let delay = Double.random(in: 4...9)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            flash()
        }
    }
    
    private func flash() {
        // Two-step flash: bright, dim, bright, gone
        withAnimation(.easeOut(duration: 0.08)) { flashOpacity = 0.7 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeIn(duration: 0.08)) { flashOpacity = 0 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation(.easeOut(duration: 0.06)) { flashOpacity = 0.5 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                    withAnimation(.easeIn(duration: 0.18)) { flashOpacity = 0 }
                    scheduleNextFlash()
                }
            }
        }
    }
}

struct FogOverlay: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.clear,
                Color.white.opacity(0.35),
                Color.white.opacity(0.55)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .allowsHitTesting(false)
    }
}
