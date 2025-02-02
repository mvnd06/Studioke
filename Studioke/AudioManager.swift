//
//  AudioManager.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import AudioKit
import AudioKitEX
import SoundpipeAudioKit

class AudioManager {
    var mic: AudioEngine.InputNode
    var tracker: PitchTap!
    var onPitchDetected: ((Float) -> Void)?
    
    init() {
        let engine = AudioEngine()
        mic = engine.input!
        tracker = PitchTap(mic) { pitch, _ in
            DispatchQueue.main.async {
                self.onPitchDetected?(pitch.first ?? 0.0)
            }
        }
        try? engine.start()
    }
    
    func startTracking() {
        tracker.start()
    }
    
    func stopTracking() {
        tracker.stop()
    }
}
