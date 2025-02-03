//
//  LRCParser.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import Foundation
import SwiftUI

class LRCParser {
    var lyricsList: [String] = []
    var timestamps: [String: Int] = [:]
    var animationLength: [Double] = []
    var numberOfLines: [Int] = []

    init(lrcString: String) {
        parseLRC(lrcString)
    }

    private func parseLRC(_ lrc: String) {
        let lines = lrc.components(separatedBy: "\n")
        var index = 0
        var timeValues: [Double] = []

        let regex = try! NSRegularExpression(pattern: "\\[(\\d{2}):(\\d{2})\\.(\\d{2})\\](.*)", options: [])

        for line in lines {
            if let match = regex.firstMatch(in: line, options: [], range: NSRange(location: 0, length: line.utf16.count)) {
                let timestampString = (line as NSString).substring(with: match.range(at: 1)) + ":" +
                                      (line as NSString).substring(with: match.range(at: 2)) + "." +
                                      (line as NSString).substring(with: match.range(at: 3))

                let minutes = Int((line as NSString).substring(with: match.range(at: 1))) ?? 0
                let seconds = Int((line as NSString).substring(with: match.range(at: 2))) ?? 0
                let milliseconds = Int((line as NSString).substring(with: match.range(at: 3))) ?? 0
                let totalSeconds = Double(minutes * 60) + Double(seconds) + Double(milliseconds) / 100.0

                timeValues.append(totalSeconds)

                let lyric = (match.range(at: 4).location != NSNotFound) ?
                    (line as NSString).substring(with: match.range(at: 4)).trimmingCharacters(in: .whitespacesAndNewlines) : ""

                timestamps[timestampString] = index
                lyricsList.append(lyric)
                index += 1
            } else if !line.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // Handle cases where there's a line without a timestamp
                lyricsList.append(line)
                index += 1
            }
        }

        // Compute animation lengths (time difference between each timestamp)
        animationLength = calculateAnimationLengths(timeValues)
        let lyricsWidth: CGFloat = 400 // Set based on expected view width
        numberOfLines = lyricsList.enumerated().map { index, text in
            estimateNumberOfLines(for: text, index: index, width: lyricsWidth)
        }
    }

    private func calculateAnimationLengths(_ timeValues: [Double]) -> [Double] {
        guard !timeValues.isEmpty else { return [] }
        
        var durations: [Double] = []
        durations.append(0) // First line starts at 0
        
        for i in 1..<timeValues.count {
            let diff = timeValues[i] - timeValues[i - 1]
            durations.append(diff)
        }

        return durations
    }
    
    func estimateNumberOfLines(for text: String, index: Int, width: CGFloat) -> Int {
        let font = getUIFont(for: getFontType(i: index)) // Convert SwiftUI Font to UIFont
        let lineHeight = font.lineHeight

        let boundingSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        
        let textRect = text.boundingRect(
            with: boundingSize,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        )

        let numberOfLines = Int(ceil(textRect.height / lineHeight))
        return max(1, numberOfLines) // Ensure at least 1 line
    }
    
    func getUIFont(for font: Font) -> UIFont {
        switch font {
        case .title: return UIFont.preferredFont(forTextStyle: .title1)
        case .subheadline: return UIFont.preferredFont(forTextStyle: .subheadline)
        default: return UIFont.systemFont(ofSize: 17) // Default case
        }
    }
    
    func getFontType(i: Int) -> Font {
        return i < lyricsList.count - 1 ? .title : .subheadline
    }
}
