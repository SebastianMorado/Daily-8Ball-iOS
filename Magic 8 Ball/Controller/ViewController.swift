//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//  Updated by Sebastian Morado on 12/05/2021

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var askButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var ballManager = BallManager()
    var timer = Timer()
    let waitTime = 86400.0
    let app = UserDefaults.standard
    let formatter = DateComponentsFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ballManager.delegate = self
        if let timerStart = app.object(forKey: "date") as? Date {
            let elapsedTime = Date().timeIntervalSince(timerStart)
            if elapsedTime <= waitTime {
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
                self.askButton.alpha = 0
                self.askButton.isEnabled = false
                updateLabel(labelText: "You can ask another question tomorrow.")
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func longGesturePressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            //Store current date in UserDefaults
            app.set(Date(), forKey: "date")
            //Set timer to stop user from asking for waitTime amount of time
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
            //Ask the 8 Ball for their wisdom
            ballManager.showChoice()
            //Make the 8 ball visible, hide the ask button until timer is done
            UIView.animate(withDuration: 0.5) {
                self.askButton.alpha = 0
                self.askButton.isEnabled = false
            }
            UIView.animate(withDuration: 0.5) {
                self.imageView.alpha = 1
            }
        }
    }
    
    @objc func onTimerFires(){
        if let timerStart = app.object(forKey: "date") as? Date {
            //check how much time has elapsed
            let elapsedTime = Date().timeIntervalSince(timerStart)
            //if the time elapsed has not exceeded the wait time, update the progress bar and label. Else, reset the UI to the default
            if elapsedTime <= waitTime {
                let intTime = Int(waitTime) - Int(elapsedTime)
                let cleanRemainingTime = Double(intTime)
                //print("Wait \(intTime) more seconds")
                updateTime(remainingTime: cleanRemainingTime)
            } else {
                //print("done!")
                DispatchQueue.main.async {
                    self.imageView.alpha = 0.2
                    self.updateImage(imageName: "ball5")
                    self.askButton.alpha = 1
                    self.askButton.isEnabled = true
                    self.timeLabel.text = ""
                    self.progressBar.progress = 0
                    self.labelView.text = "You may ask one question today."
                }
                ballManager.canAskQuestion = true
                timer.invalidate()
            }
        } else {
            //print("Timer did not start properly.")
            timer.invalidate()
        }
    }
    
    func updateTime(remainingTime: TimeInterval){
        timeLabel.text = formatter.string(from: remainingTime)! + " remaining until you can ask again."
        progressBar.progress = Float(remainingTime / waitTime)
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
