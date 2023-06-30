//
//  MultiplyGameViewController.swift
//  NineNine
//
//  Created by 김정원 on 2023/06/29.
//

import UIKit

class MultiplyGameViewController: UIViewController {
    
    var gameTimer : GameTimer?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countDownView: UIView!
    
    @IBOutlet weak var timeBar: UIProgressView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownBeforeGame(countDownView: countDownView)

        
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()

    }

    
}
