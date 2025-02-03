//
//  Lyrics.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import Foundation

struct Lyrics: Identifiable {
    let id: UUID = UUID()
    var lyricsList: [String] = [
        "",
        "Freedom of mind, I'm faster than the speed of sound",
        "Let's dim the lights and shift into new paradise",
        "Little child, living wild",
        "Where do you go when you sleep at night?",
        "Can you reach the sky or walk on fire?",
        "Where do you go when you're dreaming",
        "Dreaming?",
        "When you're dreaming",
        "Where do you go when you're dreaming",
        "Dreaming?",
        "When you're dreaming",
        "Tell me where do you go",
        "Brwrabum",
        "Bubipiwrabum",
        "Brrwraabum Tana tun tun",
        "Brwrabum",
        "Bubipiwrabum",
        "Papapapa",
        "Wrrrrooomm",
        "Brwrabum",
        "Bubipiwrabum",
        "Brrwraabum Tun tun tun",
        "Brwrabum",
        "Bubipiwrabum",
        "Bwan bwan bwan wraaw",
        "Brwyuhum",
        "Bubipiyuhum",
        "Brrrwyuhum Tun tun tun",
        "Brwyuhm",
        "Bubipiyuhm",
        "Papapapa",
        "Vrrmmmmmmm",
        "Brwyuhum Bubipiyuhum",
        "Brwyuhum Bubipiyuhum",
        "Brrrwyuhum Tun tun tun",
        "Brwyuhum Bubipiyuhum",
        "Tell me where do you go",
        "Tell me where–",
        "Tell me",
        "Tell me where do you go",
        "Tell me where–",
        "Tell me",
        "Written by: Christian Valentin Brunn, Danyka Nadeau",
    ]
    var timestamps: [String: Int] = [
        "00:00.01": 0, "00:07.26": 1, "00:14.15": 2, "00:18.34": 3, "00:21.11": 4, "00:25.42": 5,
        "00:30.67": 6, "00:33.12": 7, "00:38.89": 8, "00:44.03": 9, "00:46.78": 10, "00:53.56": 11,
        "00:54.23": 12, "00:55.48": 13, "00:56.90": 14, "00:57.65": 15, "00:58.32": 16,
        "00:59.77": 17, "01:00.28": 18, "01:01.83": 19, "01:02.47": 20, "01:03.99": 21,
        "01:04.65": 22, "01:05.31": 23, "01:06.92": 24, "01:08.14": 25, "01:09.45": 26,
        "01:10.77": 27, "01:11.34": 28, "01:12.89": 29, "01:13.56": 30, "01:14.92": 31,
        "01:15.74": 32, "01:16.42": 33, "01:17.98": 34, "01:19.22": 35, "01:20.81": 36,
        "01:27.36": 37, "01:28.55": 38, "01:34.78": 39, "01:41.99": 40, "01:42.41": 41,
        "01:43.87": 42
    ]
    var numberOfLines: [Int] = [
        1, 3, 2, 1, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
    ]
    var animationLength: [Double] = [
        0, 7, 7, 6, 3, 4, 5, 3, 5, 6, 3, 7, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 3,
    ]
}
