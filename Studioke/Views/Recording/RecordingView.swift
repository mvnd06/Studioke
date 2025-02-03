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

struct RecordingView: View {
    var song: Song
    @StateObject var audioManager = AudioManager()
    @StateObject private var lyricsManager = LyricsManager()
    @State var formattedProgress: String = "00:00"
    
    @State private var isRecording = false

    var normalizedValue: Double {
        let minPitch: Double = 80.0
        let maxPitch: Double = 280.0
        let clampedPitch = min(max(audioManager.amplitude, minPitch), maxPitch)
        let normalizedValue = (clampedPitch - minPitch) / (maxPitch - minPitch)
//        print("✍🏽 normalized pitch value: \(normalizedValue)")

        return normalizedValue
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                VStack(spacing: 10) {
                    // Back Button & Title
                    Text("Recording")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
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

                    // Karaoke Lyrics Syncing
                    LyricView(song: song, formattedProgress: $formattedProgress, isPlaying: $isRecording)

                    Spacer()
                }
                .frame(height: proxy.size.height)

                Spacer()

                ControlPanel(
                    isRecording: $isRecording, normalizedValue: normalizedValue,
                    audioManager: audioManager)

            }
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
        .onChange(of: audioManager.elapsedTime) {
            formattedProgress = formatTimestamp(milliseconds: Int(audioManager.elapsedTime))
        }
        .onAppear {
//            print(song.lyrics.lyricsList)
//            print(song.lyrics.timestamps.sorted(by: { $0.value < $1.value }))
            print(song.lyrics.numberOfLines)
        }
    }
    
    func formatTimestamp(milliseconds: Int) -> String {
        let minutes = (milliseconds / 60000) // 1 minute = 60,000 ms
        let seconds = (milliseconds % 60000) / 1000 // Get remaining seconds
        let hundredths = (milliseconds % 1000) / 10 // Convert milliseconds to hundredths

        return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
    }
}
