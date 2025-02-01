//
//  Song.swift
//  Studioke
//
//  Created by Armand Raynor on 1/27/25.
//
import Foundation

struct Song: Identifiable {
    let id: UUID = UUID()
    let title: String
//    let artist: String
    let imageName: String
    /// Array of vocal stems belonging to this song
//    let stems: [Stem]
    let tags: [String]
}

let sampleSongs: [Song] = [
    Song(title: "You Right", imageName: "img1", tags: ["Trending", "Top 50 USA"]),
    Song(title: "Montero", imageName: "img2", tags: ["Top 50 USA"]),
    Song(title: "Levitating", imageName: "img3", tags: ["Trending"]),
    Song(title: "Butter", imageName: "img4", tags: ["Top 50 USA"]),
    Song(title: "Bad Habits", imageName: "img5", tags: []),
    Song(title: "Stay", imageName: "img6", tags: ["Trending"]),
    Song(title: "Kiss Me More", imageName: "img7", tags: ["Trending"]),
    Song(title: "Peaches", imageName: "img8", tags: ["Top 50 USA"]),
    Song(title: "Good 4 U", imageName: "img9", tags: ["Trending"]),
    Song(title: "Take My Breath", imageName: "img10", tags: []),
    Song(title: "Save Your Tears", imageName: "img11", tags: ["Top 50 UK"]),
    Song(title: "Blinding Lights", imageName: "img12", tags: ["Top 50 USA", "Top 50 UK"])
]
