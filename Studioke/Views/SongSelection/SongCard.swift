//
//  SongCard.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

struct SongCard: View {
    let song: Song

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(song.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)

            Rectangle()
                .fill(Color.black.opacity(0.15))
                .frame(height: 120)

            Text(song.title)
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .padding(12)
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
