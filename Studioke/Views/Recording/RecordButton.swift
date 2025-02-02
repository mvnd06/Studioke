//
//  RecordButton.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct RecordButton: View {
    @Binding var isRecording: Bool

    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.3)) {
                isRecording.toggle()
            }
        }) {
            ZStack {
                // Outer ring
                Circle()
                    .stroke(Color.white, lineWidth: 4)
                    .frame(width: 70, height: 70)
                
                // Inner shape: a RoundedRectangle that acts like a circle when not recording,
                // and shrinks to a square when recording.
                RoundedRectangle(cornerRadius: isRecording ? 8 : 35, style: .continuous)
                    .fill(Color.highlightColor)
                    .frame(width: isRecording ? 30 : 60, height: isRecording ? 30 : 60)
            }
        }
        .padding()
    }
}

