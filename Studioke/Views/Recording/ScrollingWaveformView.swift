import SwiftUI

struct ScrollingWaveformView: View {
    // The current amplitude (or normalized pitch) value, normalized to 0…1.
    var currentValue: Double
    @Binding var isRecording: Bool

    // A fixed-size buffer to hold the waveform values.
    @State private var dataPoints: [Double] = Array(
        repeating: Double.infinity, count: 75)

    // Update interval in seconds.
    let updateInterval = 0.03

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let spacing = width / CGFloat(dataPoints.count - 1)
            let centerY = height / 2
            // How far the line should extend from the center when amplitude is 1.
            let maxLineLength = height / 2

            ZStack {
                ForEach(dataPoints.indices, id: \.self) { index in
                    let amplitude = dataPoints[index]  // value between 0 and 1
                    if amplitude.isFinite {
                        let xPos = CGFloat(index) * spacing

                        // Draw a vertical line if amplitude is non-zero.
                        Path { path in
                            let topY = centerY - amplitude * maxLineLength
                            let bottomY = centerY + amplitude * maxLineLength
                            path.move(to: CGPoint(x: xPos, y: topY))
                            path.addLine(to: CGPoint(x: xPos, y: bottomY))
                        }
                        .stroke(Color.waveformStroke, lineWidth: 1)

                        // Draw a small dot at the center.
                        Circle()
                            .fill(Color.waveformStroke)
                            .frame(width: 3, height: 3)
                            .position(x: xPos, y: centerY)
                    }
                }
            }
            // Offload rendering to the GPU.
            .drawingGroup()
        }
        .onReceive(
            Timer.publish(every: updateInterval, on: .main, in: .common)
                .autoconnect()
        ) { _ in
            guard isRecording else { return }
            // Scroll the waveform data by removing the oldest point...
            dataPoints.removeFirst()
            // ...and appending the new, normalized value.
            let normalized = min(max(currentValue, 0), 1)
            dataPoints.append(normalized)
        }
    }
}
