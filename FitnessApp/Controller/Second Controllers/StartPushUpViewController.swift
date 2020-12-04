//
//  StartPushUpViewController.swift
//  FitnessApp
//
//  Created by Syimyk on 12/3/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class StartPushUpViewController: UIViewController {
    
    var countDown = 5
    var timer = Timer()

    var reps = [Int]()
    
    var listIncrementer = 0
    var numberOfReps = 0
    var numTracker = 0
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var repsLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repsLabel.text = stringArray()
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = btn.frame.width/2
        btn.backgroundColor = .gray
        
        numberOfReps = reps[numTracker]
        currentLabel.text = "Current: \(numberOfReps)"
        btn.setTitle("\(numberOfReps)", for: .normal)

    }
    

    @IBAction func btnTapped(_ sender: UIButton) {
        statusLbl.isHidden = true
        if numberOfReps >= 2{
            numberOfReps = numberOfReps - 1
            btn.setTitle("\(numberOfReps)", for: .normal)
        }else{
            if numTracker < 4{
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
                numTracker += 1
                numberOfReps = reps[numTracker]
                currentLabel.text = "Current: \(numberOfReps)"
            }else{
                statusLbl.isHidden = false
                btn.setTitle("!", for: .normal)
                 statusLbl.text = "Workout is complete"
            }
        }
    }
    
    
    
    @IBAction func doneBtnTapped(_ sender: UIButton) {
        statusLbl.isHidden = true
        if numTracker < 4{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countDownMethod), userInfo: nil, repeats: true)
            numTracker += 1
            numberOfReps = reps[numTracker]
            currentLabel.text = "Current: \(numberOfReps)"
        }else{
            statusLbl.isHidden = false
            btn.setTitle("!", for: .normal)
            statusLbl.text = "Workout is complete"
        }
    }
    
    
    
    //MARK: - Supporting Functionality
    @objc func countDownMethod(){
        statusLbl.isHidden = false
        statusLbl.text = "Rest"
        if countDown != 0{
            countDown -= 1
            btn.setTitle("\(countDown)", for: .normal)
            btn.isEnabled = false
            doneBtn.isEnabled = false
        }else{
            timer.invalidate()
            statusLbl.isHidden = true
            btn.setTitle("\(numberOfReps)", for: .normal)
            countDown = 5
            btn.isEnabled = true
            doneBtn.isEnabled = true
        }
        
        
    }
    
    
    
    //MARK: - UI code
    func stringArray() -> String{
           var list = ""
           for num in reps{
               list.append(" \(num)")
           }
           return list
       }
}