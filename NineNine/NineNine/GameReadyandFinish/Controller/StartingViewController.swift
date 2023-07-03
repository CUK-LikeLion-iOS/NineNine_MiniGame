//
//  BBStartingViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/29.
//

import UIKit
import AVFoundation
import Network

class StartingViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameStartBtn: UIImageView!

    weak var audioDelegate: AudioPlayerDelegate?
    weak var selecetedGameDelegate: SelectedGameDelegate?
    var player: AVAudioPlayer? = makeAudioPlayer(audioResource: "Game")
    let gameStartingData = GameData()
    var isConnectedNetwork = true
    let monitor = NWPathMonitor()
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
    
    override func viewDidAppear(_ animated: Bool) {
        // https://velog.io/@ellyheetov/errorhandling01 <- 알림창을 DidAppear에 띄어야하는 이유
        detectNetworkConnected()
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
    
    /* ------------------------- 네트워크 관련 메서드 ---------------------------- */
    
    func detectNetworkConnected() {
        self.monitor.start(queue: DispatchQueue.global())
        // self.isConnectedNetwork로 조건문 검사를 하는 이유 -> 빼고 검사하면 이유는 모르겠지만 두 번 실행됨
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied && self.isConnectedNetwork == false {
                DispatchQueue.main.async {
                    showAlert(title: "네트워크 연결 성공", content: "네트워크가 다시 연결되었습니다.\n게임 결과가 정상적으로 기록되고 열람됩니다.", vc: self)
                }
                self.isConnectedNetwork = true
            } else if path.status == .unsatisfied && self.isConnectedNetwork == true {
                DispatchQueue.main.async {
                    showAlert(title: "네트워크 연결 실패", content: "현재 네트워크에 연결되어 있지 않습니다.\n게임에는 지장이 없으나 게임 결과의 열람과 기록에 실패할 수 있으니 주의해 주세요.", vc: self)
                }
                self.isConnectedNetwork = false
            }
        }
    }
}
