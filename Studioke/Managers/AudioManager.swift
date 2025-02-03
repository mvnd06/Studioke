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
    // MARK: - Published Properties
    @Published var pitch: Double = 0.0
    @Published var amplitude: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0


    // MARK: - Audio Components
    var engine = AudioEngine()
    var mic: AudioEngine.InputNode?
    var pitchTap: PitchTap!
    var node: Fader!  // 🔹 Use Fader node to tap audio output
    
    private var timerTask: Task<Void, Never>?

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
            startTimeTracking()
        } catch {
            print("Error starting AudioKit: \(error.localizedDescription)")
        }
    }

    func stop() {
        engine.stop()
        pitchTap.stop()
        timerTask?.cancel()
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
    
    // MARK: - Time Tracking
    private func startTimeTracking() {
        timerTask?.cancel()
        
        timerTask = Task { [weak self] in
            while !Task.isCancelled {
                try? await Task.sleep(for: .milliseconds(10))
                await MainActor.run {
                    self?.elapsedTime += 10
                }
            }
        }
    }
}

