//
//  SongSelectionView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

struct SongSelectionView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: SongFilter? = nil
    @StateObject var viewModel = LyricsSearchViewModel()

    var filteredSongs: [Song] {
        return sampleSongs.filter { song in
            let filterMatches =
                selectedFilter.map { song.tags.contains($0.title) } ?? true
            let searchMatches =
                searchText.isEmpty
                || song.title.localizedStandardContains(searchText)
            return filterMatches && searchMatches
        }
    }

    let columns = [GridItem(.flexible()), GridItem(.flexible())]  // 2 columns
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 16) {

                // HEADER
                Text("Choose a song")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(.white)

                // SEARCH BAR
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.searchBarTextColor)
                    TextField(
                        "",
                        text: $searchText,
                        prompt:
                            Text("Search for songs, albums or artists")
                            .foregroundColor(Color.searchBarTextColor)
                    ).foregroundColor(.white)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(
                        Color.searchBarBackgroundColor)
                )
                .padding(.horizontal)

                // FILTER BUTTONS
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(SongFilter.allCases) { filter in
                            FilterButton(
                                title: filter.title,
                                isSelected: selectedFilter == filter
                            )
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    // Toggle the filter: if already selected, deselect it.
                                    if selectedFilter == filter {
                                        selectedFilter = nil
                                    } else {
                                        selectedFilter = filter
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // SONG GRID
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(filteredSongs) { song in
                            NavigationLink(
                                destination: StemSelectionView(song: song)
                            ) {
                                SongCard(song: song)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

            }
            .padding(.top)
            .background(Color.backgroundColor)
        }
        .onAppear {
            Task {
                await withTaskGroup(of: Void.self) { group in
                    for song in filteredSongs {
                        group.addTask {
                            if let lyrics = await viewModel.searchLyrics(query: song.title) {
                                await MainActor.run {
                                    song.updateLyrics(lyrics)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
