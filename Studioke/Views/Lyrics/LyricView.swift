//
//  LyricView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import SwiftUI

struct LyricView: View {
    @Binding var formattedProgress: String
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0...lyricsList.count - 1, id: \.self) { i in
                LyricLine(
                    i: i, formattedProgress: $formattedProgress)

            }
        }.padding()
            .padding()
            .offset(y: 1040)
            .frame(height: 250)
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
}
