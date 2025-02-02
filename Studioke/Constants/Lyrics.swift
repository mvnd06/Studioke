//
//  Lyrics.swift
//  Studioke
//
//  Created by Armand Raynor on 2/2/25.
//

import Foundation

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

let timestamps: [String: Int] = [
    "00:00": 0, "00:07": 1, "00:14": 2, "00:18": 3, "00:21": 4, "00:25": 5,
    "00:30": 6, "00:33": 7, "00:38": 8, "00:44": 9, "00:46": 10, "00:53": 11,
    "00:54": 12, "00:55": 13, "00:56": 14, "00:57": 15, "00:58": 16,
    "00:59": 17, "01:00": 18, "01:01": 19, "01:02": 20, "01:03": 21,
    "01:04": 22, "01:05": 23, "01:06": 24, "01:08": 25, "01:09": 26,
    "01:10": 27, "01:11": 28, "01:12": 29, "01:13": 30, "01:14": 31,
    "01:15": 32, "01:16": 33, "01:17": 34, "01:19": 35, "01:20": 36,
    "01:27": 37, "01:28": 38, "01:34": 39, "01:41": 40, "01:42": 41,
    "01:43": 42,
]
let numberOfLines: [Int] = [
    1, 3, 2, 1, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2,
]
let animationLength: [Double] = [
    0, 7, 7, 6, 3, 4, 5, 3, 5, 6, 3, 7, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
    3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 2, 1, 1, 3,
]
var textWidths: [CGFloat] = []

