//
//  AnimatedMask.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct AnimatedMask: AnimatableModifier {
    let song: Song
    var phase: CGFloat = 0
    var textWidth: CGFloat
    var lineNumber: Int

    nonisolated var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                OverlayView(song: song,
                    width: textWidth, progress: phase, lineNumber: lineNumber)
            )
            .mask(MaskTextView(song: song, lineNumber: lineNumber))
    }
}

struct OverlayView: View {
    let song: Song
    let width: CGFloat
    let progress: CGFloat
    let lineNumber: Int
    var body: some View {
        Path { path in
            for i in 0...song.lyrics.numberOfLines[lineNumber] {
                let yValue: CGFloat = (18 * CGFloat(i + 1)) + (20 * CGFloat(i))
                path.move(to: CGPoint(x: 0, y: yValue))
                path.addLine(to: CGPoint(x: width, y: yValue))
            }
        }.trim(from: 0, to: progress)
            .stroke(lineWidth: 38)
            .fill(Color.highlightColor)
    }
}

struct MaskTextView: View {
    let song: Song
    var lineNumber: Int
    var body: some View {
        Text(song.lyrics.lyricsList[lineNumber])
            .font(getFontType(i: lineNumber))
            .padding(.vertical, song.lyrics.lyricsList[lineNumber].count == 5 ? 20 : 0)
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor
    func getFontType(i: Int) -> Font {
        return i < song.lyrics.lyricsList.count - 1 ? .title : .subheadline
    }
}

