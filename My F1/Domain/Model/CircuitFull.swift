//
//  File.swift
//  My F1
//
//  Created by Piernagorda Olive Javier on 7/8/23.
//

import UIKit

struct CircuitFull{
    var circuitInfo: Circuit?
    var countryImage: UIImage?
    
    init(circuitInfo: Circuit? = nil, countryImage: UIImage? = nil) {
        self.circuitInfo = circuitInfo
        self.countryImage = countryImage
    }
}
