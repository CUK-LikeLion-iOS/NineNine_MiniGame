//
//  BBStartingViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/29.
//

import UIKit
import AVFoundation

class StartingViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameStartBtn: UIImageView!

    weak var audioDelegate: AudioPlayerDelegate?
    weak var selecetedGameDelegate: SelectedGameDelegate?
    var player: AVAudioPlayer? = makeAudioPlayer(audioResource: "Game")
    let gameStartingData = GameStartingData()
    var gameStartBtnImages: [UIImage] {
        get {
            return gameStartingData.gameStartBtnImageArray()
        }
    }
    var gameSBandVCs: [(String, String)] {
        get {
            return gameStartingData.gameStoryBoardAndViewControllers()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        renderSelectedGameResource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        gameStartBtn.image = gameStartBtnImages[0]
        audioDelegate?.playAudioPlayer()
    }
    
    func renderSelectedGameResource() {
        guard let gameNumber = selecetedGameDelegate?.selectedGameNumber() else {
            return
        }
        let gameStartingResource = gameStartingData.gameStartingResource()
        
        gameTitle.text = gameStartingResource[gameNumber].0
        gameDescription.text = gameStartingResource[gameNumber].1
        titleImage.image = gameStartingResource[gameNumber].2
    }

    /* --------------------------- IBAction 메서드 --------------------------- */
    
    @IBAction func gameStartBtnPressed(_ sender: UIButton) {
        gameStartBtn.image = gameStartBtnImages[1]
    }

    @IBAction func moveBack(_ sender: UIButton) {
        moveBackToHomeVC(vc: self)
    }

    @IBAction func moveGameView(_ sender: UIButton) {
        guard let gameNumber = selecetedGameDelegate?.selectedGameNumber() else {
            return
        }
        moveToGameVC(startingVC: self, gameSBandVC: gameSBandVCs[gameNumber])

        audioDelegate?.stopAudioPlayer() // 게임 스타트 버튼 눌리면 Main BGM 꺼짐
        player?.delegate = self
        player?.prepareToPlay()
        player?.play()
    }
//    }
    /* -------------------------------------------------------------------- */

    // 오디오 플레이어가 종료되었으면 할당 해제
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        weak var audioPlayer = player
        audioPlayer = nil
    }
}
