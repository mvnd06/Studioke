//
//  Studioke+Color.swift
//  Studioke
//
//  Created by Armand Raynor on 2/1/25.
//

import SwiftUI

extension Color {
    static let backgroundColor = Color(hex: "251124")
    static let highlightColor = Color(hex: "FF00F6")
    static let searchBarBackgroundColor = Color(hex: "4C2248")
    static let searchBarTextColor = Color(hex: "CF91C7")
    static let filterBackgroundColor = Color(hex: "4C2248")
    
    fileprivate init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let red = Double((int >> 16) & 0xFF) / 255.0
        let green = Double((int >> 8) & 0xFF) / 255.0
        let blue = Double(int & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
