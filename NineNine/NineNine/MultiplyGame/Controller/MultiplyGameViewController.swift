//
//  MultiplyGameViewController.swift
//  NineNine
//
//  Created by 김정원 on 2023/06/29.
//

import UIKit

class MultiplyGameViewController: UIViewController {
    
    var gameTimer : GameTimer?
    
    @IBOutlet weak var secondView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var timeBar: UIProgressView!
  
    @IBOutlet weak var operand2Label: UILabel!
    @IBOutlet weak var operand1Label: UILabel!
    
    @IBAction func operandButtonTapped(_ sender: UIButton)
    {
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownBeforeGame(countDownView: countDownView)
        self.secondView.isHidden = true
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
        hideHomeImage()
        makingOperand()
    }
    func makingOperand() -> Int
       {
           let randomValue1 = Int.random(in: 1...9)
           let randomValue2 = Int.random(in: 1...9)
           operand1Label.text = "\(randomValue1)"
           operand2Label.text = "\(randomValue2)"
           return randomValue1 * randomValue2
       }
    
    func hideHomeImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.homeImage.isHidden = true
            self.secondView.isHidden = false
        }
    }
}
