//
//  MultiplyGameViewController.swift
//  NineNine
//
//  Created by 김정원 on 2023/06/29.
//

import UIKit

class MultiplyGameViewController: UIViewController, GameDelegate {
    
    @IBOutlet weak var quizView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var countDownView: UIView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var operand2Label: UILabel!
    @IBOutlet weak var operand1Label: UILabel!
    @IBOutlet weak var userInputLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    
    // Game Timer 관련 프로퍼티
    var gameTimer : GameTimer?
    
    let multiplyResources = MultiplyAndPlusGameData()
    
    // 게임점수 관련 프로퍼티
    let highScore = DataStorage().loadHighScore(gameName: "MultiplyGame")
    var rank: UIColor = .systemRed
    var score: Int = 0 {
        didSet {
            let scoreBoardColor = multiplyResources.selectScoreBoardColor(score: score, highScore: self.highScore)
            scoreView.backgroundColor = scoreBoardColor[0]
            scoreLabel.textColor = scoreBoardColor[1]
            self.rank = scoreBoardColor[2]
            scoreLabel.text = "\(score)"
        }
    }
    
    /*--------------------------------------------게임 관련 프로퍼티 ------------------------------------------------*/
    var repeatCount : Int = 0
    var userInput : Int?
    var inputCount :Int = 0
    var resultNum : Int?
}

extension MultiplyGameViewController {

    @IBAction func operandButtonTapped(_ sender: UIButton)
    {
        switch sender.tag {
        case 0...9:
            // 입력받은 값이 0이면서 resultNum이 10 초과일 때와 inputCount가 0일 때는 작동하지 않음
            if !(resultNum! >= 10 && sender.tag == 0 && inputCount == 0) {
                userInput = (userInput ?? 0) * 10 + sender.tag
                inputCount += 1
                userInputLabel.text = "\(sender.tag)"
            }
        default:
            break
        }
        
        // 정답확인 후 새로운 문제 생성
        if inputCount == repeatCount {
            userInputLabel.text = ""
            checkAnswer()
            makingOperand()
            inputCount = 0
        }
    }
    // 버튼 클릭시 계산 프로퍼티
    func calculate(operand1 : Int , operand2 : Int)
    {
        self.resultNum = operand1 * operand2
        self.repeatCount = (resultNum! >= 10) ? 2 : 1
    }
    // 피연산자 관련 생성 프로퍼티
    func makingOperand()
    {
        let randomValue1 = Int.random(in: 1...9)
        let randomValue2 = Int.random(in: 1...9)
        operand1Label.text = "\(randomValue1)"
        operand2Label.text = "\(randomValue2)"
        calculate(operand1: randomValue1, operand2: randomValue2)
    }
    // 정답 체크 프로퍼티
    func checkAnswer()
    {
        if userInput == resultNum {
            userInput = nil
            score += 1
            scoreLabel.text = "\(score)"
        } else {
            userInput = nil
        }
        
    }
    // 게임 점수관련 등급 프로퍼티
    
    func gameScore() -> Int {
        return score
    }
    
    func gameRank() -> Int {
        switch self.rank {
        case .systemRed:
            return 0
        case .systemGreen:
            return 1
        case .systemBlue:
            return 2
        default:
            return 3
        }
    }
    
    /* --------------------------------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        startInitialGame()
    }
    
    // 초기 메서드 설정
    func initialSetup() {
        countDownBeforeGame(countDownView: countDownView)
        makeCornerRoundShape(targetView: scoreView, cornerRadius: 20)
        userInputLabel.layer.masksToBounds = true
        userInputLabel.layer.cornerRadius = 20
        homeImage.image = self.multiplyResources.multiplyCatImage()
        quizImage.image = self.multiplyResources.answerImage()
        self.quizView.isHidden = true
        gameTimer = GameTimer(controller: self, timeBar: timeBar, timeLabel: timeLabel)
    }
    // 초기 게임 시작 메서드 설정
    func startInitialGame() {
        hideHomeImage()
        makingOperand()
        gameTimer?.startTimer()
    }
    // 카운트 다운때 문제노출 막는 프로퍼티
    func hideHomeImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.homeImage.isHidden = true
            self.quizView.isHidden = false
        }
    }
    
}
