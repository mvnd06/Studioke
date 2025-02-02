import SwiftUI

struct ScrollingWaveformView: View {
    // The current value (e.g., pitch or amplitude) should be normalized to 0…1.
    var currentValue: Double

    // A fixed-size buffer to hold the waveform values.
    @State private var dataPoints: [Double] = Array(repeating: 0.0, count: 200)

    // Update interval in seconds.
    let updateInterval = 0.05

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let spacing = width / CGFloat(dataPoints.count - 1)

            Path { path in
                for index in dataPoints.indices {
                    let xPosition = CGFloat(index) * spacing
                    // Map the normalized value (0…1) to a Y coordinate.
                    // Here 0 is at the bottom and 1 at the top.
                    let yPosition = height * (1 - CGFloat(dataPoints[index]))
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.waveformStroke, lineWidth: 2)
        }
        .onReceive(
            Timer.publish(every: updateInterval, on: .main, in: .common)
                .autoconnect()
        ) { _ in
            // Remove the oldest point, and append the current value.
            // Optionally, apply smoothing or scaling to currentValue.
            dataPoints.removeFirst()
            // Ensure currentValue is in the 0...1 range.
            let normalized = min(max(currentValue, 0), 1)
            dataPoints.append(normalized)
        }
    }
}
