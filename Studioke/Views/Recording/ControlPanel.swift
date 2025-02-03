//
//  ControlPanel.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct ControlPanel: View {
    @Binding var isRecording: Bool
    let normalizedValue: Double
    @ObservedObject var audioManager: AudioManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.filterBackgroundColor.opacity(0.8))
                .frame(height: isRecording ? 380 : 180)  // Expands when recording starts
                .overlay(
                    VStack {
                        VStack(spacing: 10) {
                            // Pitch Meter Display
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Pitch Meter")
                                    .foregroundColor(.white)

                                Text("C4")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)

                                Text(
                                    "Real-time \(audioManager.amplitude, specifier: "%.1f")%"
                                )
                                .foregroundColor(
                                    audioManager.amplitude >= 0 ? .green : .red)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .opacity(isRecording ? 1 : 0)
                            .transition(.opacity)

                            ScrollingWaveformView(
                                currentValue: normalizedValue,
                                isRecording: $isRecording
                            )
                            .frame(height: 80)
                            .opacity(isRecording ? 1 : 0)
                            .transition(.opacity)

                            Spacer()
                        }
                        .padding(.top, 10)
                    }
                )
                .animation(.easeInOut(duration: 0.3), value: isRecording)  // Smooth expand animation
                .offset(y: 60)  // Moves it down slighly below safe area

            RecordButton(isRecording: $isRecording)
        }
    }
}
