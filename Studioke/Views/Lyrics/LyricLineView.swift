//
//  LyricLineView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct LyricLine: View {
    @State var lineNumber: Int = 0
    var i: Int
    @State var phase: CGFloat = 0
    @State var textWidth: CGFloat = 0
    @Binding var formattedProgress: String
    @State var offset: CGFloat = 0

    // Add @MainActor to ensure UI updates happen on main thread
    @MainActor func updateLine(scrollToLine: Int, beginAnimation: Bool = true) {
        withAnimation(.spring()) {
            lineNumber = scrollToLine + 1
        }
        guard beginAnimation else { return }
        phase = 0
        withAnimation(.easeInOut(duration: animationLength[lineNumber])) {
            phase = 1
        }
    }

    var body: some View {
        Text(lyricsList[i])
            .font(getFontType(i: i))
            .padding(.vertical, lyricsList[i].count == 5 ? 20 : 0)
            .bold()
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            .modifier(
                i == lineNumber
                    ? AnimatedMask(
                        phase: phase, textWidth: textWidth,
                        lineNumber: lineNumber)
                    : AnimatedMask(textWidth: 0, lineNumber: i)
            )
            .blur(radius: i == lineNumber ? 0 : 4)
            .background(
                GeometryReader { g in
                    if i == lineNumber {
                        Color.clear.onAppear {
                            textWidth = g.size.width
                        }
                    }
                }
            )
            .offset(y: offset)
            .onChange(of: formattedProgress) {
                if let scrollToLine = timestamps[formattedProgress] {
                    Task { @MainActor in  // Ensure main thread execution
                        updateLine(scrollToLine: scrollToLine)
                        let offsetChange =
                            (33.6 * CGFloat(numberOfLines[scrollToLine])) + 20
                        withAnimation(.spring()) {
                            offset -= offsetChange
                        }
                    }
                }
            }
            .onAppear {
                if let scrollToLine = timestamps["00:00"] {
                    updateLine(
                        scrollToLine: scrollToLine, beginAnimation: false)
                    withAnimation(.spring()) {
                        offset -= 15
                    }
                }
            }
    }
}
