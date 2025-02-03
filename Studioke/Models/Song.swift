//
//  Song.swift
//  Studioke
//
//  Created by Armand Raynor on 1/27/25.
//
import Foundation

class Song: Identifiable {
    let id: UUID = UUID()
    let title: String
    let artist: String
    let imageName: String
    let tags: [String]
    var lyrics: Lyrics = Lyrics()
    
    func updateLyrics(_ lyrics: Lyrics) {
        self.lyrics = lyrics
    }
    
    init(title: String, artist: String, imageName: String, tags: [String], lyrics: Lyrics = Lyrics()) {
        self.title = title
        self.artist = artist
        self.imageName = imageName
        self.tags = tags
        self.lyrics = lyrics
    }
}

/// Array of vocal stems belonging to this song
//    let stems: [Stem]

let sampleSongs: [Song] = [
    Song(title: "You Right (feat. The Weeknd)", artist: "Doja Cat", imageName: "img1", tags: ["Trending", "Top 50 USA"]),
    Song(title: "Montero", artist: "Lil Nas X", imageName: "img2", tags: ["Top 50 USA"]),
    Song(title: "Levitating (feat. DaBaby)", artist: "Dua Lipa", imageName: "img3", tags: ["Trending"]),
    Song(title: "Butter", artist: "BTS", imageName: "img4", tags: ["Top 50 USA"]),
    Song(title: "Bad Habits", artist: "Ed Sheeran", imageName: "img5", tags: []),
    Song(title: "Stay", artist: "The Kid LAROI", imageName: "img6", tags: ["Trending"]),
    Song(title: "Kiss Me More (feat. SZA)", artist: "Doja Cat", imageName: "img7", tags: ["Trending"]),
    Song(title: "Peaches (feat. Daniel Caesar & Giveon)", artist: "Justin Bieber", imageName: "img8", tags: ["Top 50 USA"]),
    Song(title: "Good 4 U", artist: "Olivia Rodrigo", imageName: "img9", tags: ["Trending"]),
    Song(title: "Take My Breath", artist: "The Weeknd", imageName: "img10", tags: []),
    Song(title: "Save Your Tears", artist: "The Weeknd", imageName: "img11", tags: ["Top 50 UK"]),
    Song(title: "Blinding Lights", artist: "The Weeknd", imageName: "img12", tags: ["Top 50 USA", "Top 50 UK"])
]


