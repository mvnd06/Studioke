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
    @State var formattedProgress: String = "00:00"

    @State private var isRecording = false

    var normalizedValue: Double {
        let minPitch: Double = 80.0
        let maxPitch: Double = 280.0
        let clampedPitch = min(max(audioManager.amplitude, minPitch), maxPitch)
        let normalizedValue = (clampedPitch - minPitch) / (maxPitch - minPitch)
        print("✍🏽 normalized pitch value: \(normalizedValue)")

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
                    LyricView(formattedProgress: $formattedProgress)
                    
                    Spacer()
                }
                .frame(height: proxy.size.height)
                
                Spacer()
                
                ControlPanel(isRecording: $isRecording, normalizedValue: normalizedValue, audioManager: audioManager)
                
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
    }
}
