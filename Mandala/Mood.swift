//
//  Mood.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/12/25.
//

import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
}

extension Mood {
    static let angry = Mood(name: "angry", image: .angry, color: .angryRed)  // built-in within Xcode
    //    static let angry = Mood(name: "confused", image: UIImage(usingResource: .angry), color: .angry)  // via extension
    static let confused = Mood(name: "confused", image: .confused, color: .confusedPurple)
    static let crying = Mood(name: "crying", image: .crying, color: .cryingLightBlue)
    static let goofy = Mood(name: "goofy", image: .goofy, color: .goofyOrange)
    static let happy = Mood(name: "happy", image: .happy, color: .happyTurquoise)
    static let meh = Mood(name: "meh", image: .meh, color: .mehGray)
    static let sad = Mood(name: "sad", image: .sad, color: .sadBlue)
    static let sleepy = Mood(name: "sleepy", image: .sleepy, color: .sleepyLightRed)
}
