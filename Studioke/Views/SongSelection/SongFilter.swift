//
//  SongFilter.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

enum SongFilter: String, CaseIterable, Identifiable {
    case trending
    case top50USA
    case top50UK

    var id: Self { self }

    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .top50USA:
            return "Top 50 USA"
        case .top50UK:
            return "Top 50 UK"
        }
    }
}

struct FilterButton: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline)
            .bold()
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        isSelected ? Color.filterBackgroundColor : Color.clear)
            )
            .foregroundColor(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(
                        isSelected ? Color.clear : Color.filterBackgroundColor,
                        lineWidth: 2)
            )
    }
}
