//
//  TabTabGameViewController.swift
//  NineNine
//
//  Created by 김희은 on 2023/06/30.
//
//점수 0점 수정
//점수에 따라 색깔 수정
//오토레이아웃

import UIKit

class TabTabGameViewController: UIViewController, GameDelegate {
    
    @IBOutlet weak var tappingCatImage: UIImageView!
    @IBOutlet weak var cheeseButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let gameResource: TapTapGameData = TapTapGameData()
    var score: Int = 0
    
    //lazy var를 위치 옮겨서 let으로 처리할 것
    lazy var tapCheeseImage = gameResource.cheeseButtonImageArray()
    lazy var pushingCatImage = gameResource.pushingCatImageArray()
    
    lazy var pushingCat = pushingCatImage[1]
    lazy var notPushingCat = pushingCatImage[0]
    
    lazy var pushedButton = tapCheeseImage[1]
    lazy var notPushedButton = tapCheeseImage[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.scoreLabel.text = "\(score)"
        tappingCatImage.image = notPushingCat
        makeCornerRoundShape(targetView: scoreLabel, cornerRadius: 20)
        timeTravel()
    }
    
    @IBAction func ordinaryButton() {
        tappingCatImage.image = notPushingCat
        cheeseButton.isHighlighted = false
        print(cheeseButton.isHighlighted)
    }
    
    
    @IBAction func buttonAction(_ sender: Any) {
        cheeseButton.isHighlighted = true
        print(cheeseButton.isHighlighted)
        
        if cheeseButton.isHighlighted == true {
            tappingCatImage.image = pushingCat
            //ordinaryButton()
        }
    }
    
    //탭탭 버튼 전환 구현부
    @IBAction func buttonTouchDown(_ sender: Any) {
        self.score += 1
        self.scoreLabel.text = "\(score)"
        buttonSelected()
    }
    @IBAction func buttonTouchUp(_ sender: Any) {
        buttonNormalMode()
    }

    func buttonNormalMode() {
        tappingCatImage.image = notPushingCat
    }

    func buttonSelected() {
        tappingCatImage.image = pushingCat
    }

    func showGameResult() -> Int {
        return score
    }
    
    func timeTravel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 13.0) {
            print("finish")
            moveToGameResultVC(gameVC: self)
        }
    }
    
}
