//
//  UIImage+Mandala.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/12/25.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    convenience init(usingResource resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
}
