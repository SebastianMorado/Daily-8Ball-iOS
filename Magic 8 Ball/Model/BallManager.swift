//
//  BallManager.swift
//  Magic 8 Ball
//
//  Created by Sebastian Morado on 5/12/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

protocol BallManagerDelegate {
    func updateImage(imageName : String)
    func updateLabel(labelText: String)
}

struct BallManager {
    var canAskQuestion = true
    var delegate : BallManagerDelegate?
    
    mutating func showChoice() {
        if canAskQuestion {
            canAskQuestion = false
            let newImageTitle = "ball" + String(Int.random(in: 1...4))
            delegate?.updateImage(imageName: newImageTitle)
            delegate?.updateLabel(labelText: "You can ask another question tomorrow.")

        }
    }
}
