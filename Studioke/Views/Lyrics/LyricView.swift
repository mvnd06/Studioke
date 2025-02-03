//
//  LyricView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct LyricView: View {
    var song: Song
    @Binding var formattedProgress: String
    @Binding var isPlaying: Bool
    
    @State private var totalHeight: CGFloat = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0...song.lyrics.lyricsList.count - 1, id: \.self) { index in
                LyricLine(
                    song: song, index: index,
                    formattedProgress: $formattedProgress,
                    isPlaying: $isPlaying
                )
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                DispatchQueue.main.async {
                                    totalHeight += geo.size.height + 20  // Add spacing
                                }
                            }
                    })

            }
        }.padding()
            .padding()
            .offset(y: (totalHeight / 2) - 100)
            .frame(height: 350)
            .mask {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .clear, location: .zero),
                        Gradient.Stop(color: .black, location: 0.01),
                        Gradient.Stop(color: .black, location: 0.65),
                        Gradient.Stop(color: .clear, location: 1.0),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }

    func measureLineHeight(index: Int) -> CGFloat {
        let text = song.lyrics.lyricsList[index]

        // Estimate text height dynamically
        let font = getFontType(i: index)
        let size = text.size(withAttributes: [
            .font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        ])

        return size.height
    }

    @MainActor
    func getFontType(i: Int) -> Font {
        return i < song.lyrics.lyricsList.count - 1 ? .title : .subheadline
    }
}
