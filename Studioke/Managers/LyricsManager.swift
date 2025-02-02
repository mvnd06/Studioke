//
//  LyricsManager.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

class LyricsManager: ObservableObject {
    @Published var currentLineIndex = 0

    let lyrics = [
        "This is the first line of the song",
        "This is the second line of the song",
        "This is the third line of the song"
    ]

    func updateLyrics(at time: Double) {
        let index = Int(time) % lyrics.count
        if index != currentLineIndex {
            currentLineIndex = index
        }
    }
}
