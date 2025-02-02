//
//  StemSelectionView.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

struct StemSelectionView: View {
    let song: Song
    
    @State private var selectedStem: String? = "Lead Vocal"
    
    let stems = [
        ("Lead Vocal", "mic.fill"),
        ("Harmony", "music.mic"),
        ("Bass", "waveform.path.ecg")
    ]
    
    var body: some View {
        VStack {
            // Header Section
            VStack(spacing: 5) {
                Text(song.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(song.artist)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
            .padding(.top, 20)
            
            Spacer()
            
            // Instruction Text
            VStack(spacing: 8) {
                Text("Choose A Stem to Record")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Each song has multiple vocal parts (stems). Select one to record your own version!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            // Stem List
            VStack {
                ForEach(stems, id: \.0) { stem in
                    StemRow(title: stem.0, iconName: stem.1, isSelected: selectedStem == stem.0) {
                        selectedStem = stem.0
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            // Start Recording Button
            Button(action: {
                print("Start Recording: \(selectedStem ?? "")")
            }) {
                Text("Start Recording")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.highlightColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct StemRow: View {
    var title: String
    var iconName: String
    var isSelected: Bool
    var onSelect: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text("3:28")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Circle()
                .stroke(isSelected ? Color.highlightColor : Color.gray, lineWidth: 2)
                .frame(width: 25, height: 25)
                .background(isSelected ? Color.highlightColor : Color.clear)
                .clipShape(Circle())
                .onTapGesture {
                    onSelect()
                }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(12)
    }
}
