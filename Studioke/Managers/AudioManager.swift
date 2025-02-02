//
//  PitchManager.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import AVFoundation
import AudioKit
import AudioKitEX
import AudioKitUI
import SoundpipeAudioKit
import SwiftUI

class AudioManager: ObservableObject {
    @Published var pitch: Double = 0.0
    @Published var amplitude: Double = 0.0

    var engine = AudioEngine()
    var mic: AudioEngine.InputNode?

    var pitchTap: PitchTap!
    var node: Fader!  // 🔹 Use Fader node to tap audio output

    init() {
        configureAudioSession()

        if let input = engine.input {
            mic = input
        } else {
            print("🚨 No valid microphone input found!")
            return
        }

        // 🔹 Attach a Fader node to capture the microphone input
        node = Fader(mic!)
        engine.output = node

        pitchTap = PitchTap(mic!) { pitch, amplitude in
            // We'll use the first pitch value if available.
            DispatchQueue.main.async {
                self.pitch = Double(pitch[0])
                self.amplitude = Double(pitch[1])
            }
        }
    }

    func start() {
        do {
            try engine.start()
            pitchTap.start()
        } catch {
            print("Error starting AudioKit: \(error.localizedDescription)")
        }
    }

    func stop() {
        engine.stop()
        pitchTap.stop()
    }

    /// Configures AVAudioSession
    private func configureAudioSession() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(
                .playAndRecord, mode: .default,
                options: [.defaultToSpeaker, .allowBluetooth])
            try session.setActive(true)
            print("✅ AVAudioSession configured successfully")
        } catch {
            print(
                "❌ Error configuring AVAudioSession: \(error.localizedDescription)"
            )
        }
    }
}
