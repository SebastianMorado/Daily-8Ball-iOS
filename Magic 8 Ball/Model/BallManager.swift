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
    var questionCount = 5
    var delegate : BallManagerDelegate?
    
    mutating func showChoice() {
        if questionCount > 0{
            questionCount -= 1
            let newImageTitle = "ball" + String(Int.random(in: 1...4))
            delegate?.updateImage(imageName: newImageTitle)
            if questionCount == 0 {
                delegate?.updateLabel(labelText: "You cannot ask any more questions")
            } else if questionCount == 1 {
                delegate?.updateLabel(labelText: "You can ask \(questionCount) more question")
            } else {
                delegate?.updateLabel(labelText: "You can ask \(questionCount) more questions")
            }
        } else {
            delegate?.updateImage(imageName: "ball5")
        }
    }
}
