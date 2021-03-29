//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var questionCount = 5
    let ballArray = [#imageLiteral(resourceName: "ball1"),#imageLiteral(resourceName: "ball2"),#imageLiteral(resourceName: "ball3"),#imageLiteral(resourceName: "ball4"),#imageLiteral(resourceName: "ball5")]
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        if questionCount > 0{
            questionCount -= 1
            imageView.image = ballArray.randomElement()
            if questionCount == 0 {
                labelView.text = "You cannot ask any more questions"
            } else if questionCount == 1 {
                labelView.text = "You can ask \(questionCount) more question"
            } else {
                labelView.text = "You can ask \(questionCount) more questions"
            }
        }
        
    }
}

