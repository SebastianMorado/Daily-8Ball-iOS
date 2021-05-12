//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    var ballManager = BallManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballManager.delegate = self
    }
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        ballManager.showChoice()
    }
}

//MARK: - BallManagerDelegate

extension ViewController: BallManagerDelegate {
    func updateImage(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    func updateLabel(labelText: String){
        labelView.text = labelText
    }
}
