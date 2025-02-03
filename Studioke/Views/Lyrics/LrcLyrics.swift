//
//  LrcLyrics.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import Foundation
import SwiftUI

// MARK: - Data Models
struct LrcLyrics: Codable, Identifiable {
    let id: Int
    let name: String
    let trackName: String
    let artistName: String
    let albumName: String?
    let duration: Double
    let instrumental: Bool
    let plainLyrics: String?
    let syncedLyrics: String?

    enum CodingKeys: String, CodingKey {
        case id, name, duration, instrumental
        case trackName = "trackName"
        case artistName = "artistName"
        case albumName = "albumName"
        case plainLyrics = "plainLyrics"
        case syncedLyrics = "syncedLyrics"
    }

    // Computed property for display
    var displayTitle: String {
        return "\(trackName) - \(artistName)"
    }
}

// MARK: - API Client
class LyricsAPIClient {
    static let shared = LyricsAPIClient()
    private let baseURL = "https://lrclib.net/api"

    func searchLyrics(query: String) async throws -> [LrcLyrics] {
        guard
            let encodedQuery = query.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "\(baseURL)/search?q=\(encodedQuery)")
        else {
            throw LyricsAPIError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([LrcLyrics].self, from: data)
        } catch {
            print(
                "Raw JSON response: \(String(data: data, encoding: .utf8) ?? "")"
            )
            throw LyricsAPIError.decodingError(error)
        }
    }
}

// MARK: - Error Handling
enum LyricsAPIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid search query"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError(let error):
            return "Failed to parse lyrics: \(error.localizedDescription)"
        }
    }
}

// MARK: - Usage in SwiftUI
class LyricsSearchViewModel: ObservableObject {
    @Published var searchResults: [LrcLyrics] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    var filteredResults: [LrcLyrics] {
        searchResults.filter({ $0.syncedLyrics != nil })
    }

    func searchLyrics(query: String) async -> Lyrics? {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }
        
        do {
            let results = try await LyricsAPIClient.shared.searchLyrics(query: query)
            
            await MainActor.run {
                searchResults = results
                isLoading = false
            }
            
            // Ensure there's at least one result with synced lyrics
            guard let lrcString = results.first?.syncedLyrics, !lrcString.isEmpty else {
                await MainActor.run {
                    errorMessage = "No synced lyrics found."
                }
                return nil
            }

            let parser = LRCParser(lrcString: lrcString)
            
            return Lyrics(
                lyricsList: parser.lyricsList,
                timestamps: parser.timestamps,
                numberOfLines: parser.numberOfLines,
                animationLength: parser.animationLength
            )
            
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                isLoading = false
            }
            return nil
        }
    }

}

struct LyricsSearchView: View {
    @StateObject var viewModel = LyricsSearchViewModel()
    @State private var searchQuery = ""

    var body: some View {
        NavigationStack {
            List(viewModel.filteredResults) { lyrics in
                VStack(alignment: .leading) {
                    Text(lyrics.displayTitle)
                        .font(.headline)

                    if let album = lyrics.albumName {
                        Text(album)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if let syncedLyrics = lyrics.syncedLyrics {
                        Text(syncedLyrics)
                            .font(.caption)
                            .lineLimit(3)
                            .padding(.top, 4)
                    }
                }
            }
            .searchable(text: $searchQuery)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.searchLyrics(query: searchQuery)
                }
            }
            .navigationTitle("Lyrics Search")
        }
    }
}
