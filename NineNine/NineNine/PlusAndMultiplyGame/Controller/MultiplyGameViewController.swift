//
//  MultiplyGameViewController.swift
//  NineNine
//
//  Created by 김정원 on 2023/06/29.
//

import UIKit

class MultiplyGameViewController: UIViewController, GameDelegate {
    
    private var gameTimer : GameTimer?
    private var repeatCount : Int = 0
    private var userInput : Int?
    private var inputCount :Int = 0
    private var resultNum : Int?
    let multiplyResources = MultiplyAndPlusGameData()
    let highScore = DataStorage().loadHighScore(gameName: "BBGame")
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = multiplyResources.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            scoreLabel.text = "\(score)"
        }
    }
    
    
    @IBOutlet private weak var quizView: UIStackView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var countDownView: UIView!
    @IBOutlet private weak var homeImage: UIImageView!
    @IBOutlet private weak var timeBar: UIProgressView!
    @IBOutlet private weak var scoreView: UIView!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var operand2Label: UILabel!
    @IBOutlet private weak var operand1Label: UILabel!
    @IBOutlet private weak var userInputLabel: UILabel!
    @IBOutlet private weak var quizImage: UIImageView!
    
    // 버튼이 눌렸을 때 기능
    @IBAction private func operandButtonTapped(_ sender: UIButton)
    {
        
        switch sender.tag {
        case 0...9:
            if inputCount == 0 || resultNum! < 10
            {
                userInput = sender.tag
                inputCount += 1
            }
            // 결과가 10 이상인 것은 두번의 입력 필요
            else if resultNum! >= 10 && inputCount == 1 {
                userInput = userInput! * 10 + sender.tag
                inputCount += 1
            }
            userInputLabel.text = "\(sender.tag)"

        default:
            break
        }
        if inputCount == repeatCount {
            userInputLabel.text = ""
            checkAnswer()
            makingOperand()
            inputCount = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDownBeforeGame(countDownView: countDownView)
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        userInputLabel.layer.masksToBounds = true
        userInputLabel.layer.cornerRadius = 20
        homeImage.image = self.multiplyResources.multiplyCatImage()
        quizImage.image = self.multiplyResources.answerImage()
        self.quizView.isHidden = true
        
        // 게임 타이머
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
        gameTimer?.startTimer()
        
        // 필수구현기능
        hideHomeImage()
        makingOperand()
    }
    // 피연산자를 만드는 함수 , 곱한 값을 반환받음
    private func makingOperand()
    {
        let randomValue1 = Int.random(in: 1...9)
        let randomValue2 = Int.random(in: 1...9)
        operand1Label.text = "\(randomValue1)"
        operand2Label.text = "\(randomValue2)"
        calculate(operand1: randomValue1, operand2: randomValue2)
    }
    
    private func calculate(operand1 : Int , operand2 : Int)
    {
        self.resultNum = operand1 * operand2
        self.repeatCount = (resultNum! >= 10) ? 2 : 1
    }
    
    private func checkAnswer()
    {
        if userInput == resultNum {
            userInput = nil
            score += 1
            scoreLabel.text = "\(score)"
        }
        
    }
   
    // 처음 계산 화면이 안보이기 위함
    private func hideHomeImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.homeImage.isHidden = true
            self.quizView.isHidden = false
        }
    }
    func showGameResult() -> Int {
        return score
    }
}
