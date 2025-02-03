//
//  LyricLineView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct LyricLine: View {
    var song: Song
    var index: Int
    @Binding var formattedProgress: String
    @Binding var isPlaying: Bool

    @State var offset: CGFloat = 0
    @State var lineNumber: Int = 0
    @State var phase: CGFloat = 0
    @State var textWidth: CGFloat = 0

    // Add @MainActor to ensure UI updates happen on main thread
    @MainActor func updateLine(scrollToLine: Int) {
        withAnimation(.spring()) {
            lineNumber = scrollToLine + 1
        }
        phase = 0
        withAnimation(
            .easeInOut(duration: song.lyrics.animationLength[lineNumber])
        ) {
            phase = 1
        }
    }

    var body: some View {
        let isLineHighlited = index == lineNumber

        Text(song.lyrics.lyricsList[index])
            .font(getFontType(i: index))
            .padding(
                .vertical, song.lyrics.lyricsList[index].count == 5 ? 20 : 0
            )
            .bold()
            .foregroundStyle(.secondary)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .modifier(
                isLineHighlited
                    ? AnimatedMask(
                        song: song,
                        phase: phase, textWidth: textWidth,
                        lineNumber: lineNumber)
                    : AnimatedMask(song: song, textWidth: 0, lineNumber: index)
            )
            .blur(radius: isLineHighlited ? 0 : 4)
            .background(
                GeometryReader { g in
                    if isLineHighlited {
                        Color.clear.onAppear {
                            textWidth = g.size.width
                        }
                    }
                }
            )
            .offset(y: offset)
            .onChange(of: formattedProgress) {
                if let scrollToLine = song.lyrics.timestamps[formattedProgress] {
                    Task { @MainActor in
                        updateLine(scrollToLine: scrollToLine)

                        // Dynamically measure the line height
                        let lineHeight = measureLineHeight(index: scrollToLine)
                        let offsetChange = lineHeight + 20 // Add some padding

                        withAnimation(.spring()) {
                            offset -= offsetChange
                        }
                    }
                }
            }
            .onChange(of: isPlaying) {
                if isPlaying,
                    formattedProgress == "00:00.01",
                    let line = song.lyrics.timestamps[formattedProgress]
                {
                    updateLine(
                        scrollToLine: line)
                    withAnimation(.spring()) {
                        offset -= 15
                    }
                }
            }
    }

    @MainActor
    func getFontType(i: Int) -> Font {
        return i < song.lyrics.lyricsList.count - 1 ? .title : .subheadline
    }
    
    func measureLineHeight(index: Int) -> CGFloat {
        let text = song.lyrics.lyricsList[index]

        // Estimate text height dynamically
        let font = getFontType(i: index)
        let size = text.size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)])

        return size.height
    }
}
