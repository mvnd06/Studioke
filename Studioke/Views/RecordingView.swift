//
//  RecordingView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import AudioKit
import AudioKitEX
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI
import Waveform

struct RecordingView: View {
    @StateObject var audioManager = AudioManager()
    @StateObject private var lyricsManager = LyricsManager()

    @State private var isRecording = false

    var normalizedValue: Double {
        let minPitch: Double = 80.0
        let maxPitch: Double = 280.0
        print("🕚 current pitch value: \(audioManager.pitch)")
        let clampedPitch = min(max(audioManager.pitch, minPitch), maxPitch)
        let normalizedValue = (clampedPitch - minPitch) / (maxPitch - minPitch)
        print("✍🏽 normalized pitch value: \(normalizedValue)")

        return normalizedValue
    }

    var body: some View {
        VStack {
            // Back Button & Title
            Text("Recording")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding()

            // Pitch Meter Display
            VStack(alignment: .leading, spacing: 5) {
                Text("Pitch Meter")
                    .foregroundColor(.white)

                Text("C4")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("Real-time \(audioManager.pitch, specifier: "%.1f")%")
                    .foregroundColor(audioManager.pitch >= 0 ? .green : .red)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)

            ScrollingWaveformView(currentValue: normalizedValue)
                .frame(height: 150)
                .background(Color.backgroundColor)
                .cornerRadius(10)
                .padding()

            // Selected Stem
            VStack {
                HStack {
                    Image("img1")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)

                    VStack(alignment: .leading) {
                        Text("Lead Vocal")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Track 1")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .background(Color.filterBackgroundColor.opacity(0.4))
                .cornerRadius(12)
            }
            .padding(.horizontal)

            //            // Karaoke Lyrics Syncing
            //            VStack {
            //                Text("Recording Progress")
            //                    .font(.headline)
            //                    .foregroundColor(.white)
            //                    .frame(maxWidth: .infinity, alignment: .leading)
            //                    .padding(.horizontal)
            //
            //                ProgressView(
            //                    value: Double(lyricsManager.currentLineIndex)
            //                        / Double(lyricsManager.lyrics.count)
            //                )
            //                .progressViewStyle(LinearProgressViewStyle())
            //                .padding(.horizontal)
            //
            //                Spacer()
            //
            //                ForEach(0..<lyricsManager.lyrics.count, id: \.self) { index in
            //                    Text(lyricsManager.lyrics[index])
            //                        .foregroundColor(
            //                            lyricsManager.currentLineIndex == index
            //                                ? .pink : .gray
            //                        )
            //                        .font(
            //                            lyricsManager.currentLineIndex == index
            //                                ? .title3.bold() : .body)
            //                }

            Spacer()

            HStack {
                Button("A") {}
                    .padding()
                    .background(Color.filterBackgroundColor)
                    .cornerRadius(50)
                    .tint(.white)

                Button("B") {}
                    .padding()
                    .background(Color.filterBackgroundColor)
                    .cornerRadius(50)
                    .tint(.white)
            }
            //            }
            .padding()

            // Recording Button
            RecordButton(isRecording: $isRecording)
        }
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
        .onChange(of: isRecording) {
            if isRecording {
                // Start recording using your audio manager.
                print("Recording started")
                audioManager.start()
            } else {
                // Stop recording.
                print("Recording stopped")
                audioManager.stop()
            }
        }
    }
}
