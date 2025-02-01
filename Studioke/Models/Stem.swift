//
//  Stem.swift
//  Studioke
//
//  Created by Armand Raynor on 1/27/25.
//
import Foundation

struct Stem: Identifiable {
    let id: UUID = UUID()
    let name: String // e.g., "Main Vocal", "Harmony 1"
    let audioURL: URL // Local or remote URL for the stem audio file
}

