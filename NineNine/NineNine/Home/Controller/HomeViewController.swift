//
//  ViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/21.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AudioPlayerDelegate, SelectedGameDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var gameListHeadView: UIView!
    @IBOutlet weak var gameContentsTableView: UITableView!
    
    let data = HomeData()
    var gameNumber: Int!
    var player: AVAudioPlayer? = makeAudioPlayer(audioResource: "Main")

    override func viewDidLoad() {
        super.viewDidLoad()

        gameContentsTableView.delegate = self
        gameContentsTableView.dataSource = self
        
        self.makeViewRoundShape(cornerRadius: 20)
        gameContentsTableView.backgroundColor = UIColor(hex: "#F4F4F4")
        playAudioPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = gameContentsTableView.indexPathForSelectedRow {
            gameContentsTableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    /* ----- UITableViewDataSource 프로토콜 필수 구현 메소드 ------ */

    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    // 각 셀의 이미지와 타이틀 레이블 설정하는 부분
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = gameContentsTableView.dequeueReusableCell(withIdentifier: "gameContentCell", for: indexPath) as! GameContentsTableViewCell
        let gameTitleArray: [String] = data.gameTitleArray()
        let gameImageArray: [UIImage] = data.gameImageArray()
        
        cell.gameTitleLabel.text = gameTitleArray[indexPath.section]
        cell.gameImageView.image = gameImageArray[indexPath.section]
        
        return cell
    }
    
    
    /* ------------------------------------------------------ */
    
    /* ---------------- UITableView 관련 메서드 ---------------- */
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.gameTitleArray().count
    }
    
    // 각각의 테이블 뷰 셀에 따라 다른 게임 시작 화면으로 이동하는 부분
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.gameNumber = indexPath.section
        moveToStartingVC(mainVC: self)
    }

    func makeViewRoundShape(cornerRadius: CGFloat) {
        gameListHeadView
            .layer.cornerRadius = cornerRadius
        gameListHeadView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        gameContentsTableView
            .layer.cornerRadius = cornerRadius
        gameContentsTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    /* ------------------------------------------------------ */

    
    /* -------------------- 오디오 관련 메서드 ------------------ */
    
    // 오디오 플레이어가 성공적으로 종료되었으면 다시 재생, 아니면 할당 해제

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (flag) {
            player.prepareToPlay()
            player.play()
        }
        else {
            weak var audioPlayer = player
            audioPlayer = nil
        }
    }
    
    // AudioPlayerDelegate 필수 구현 메서드
    func playAudioPlayer() {
        player?.delegate = self
        player?.prepareToPlay()
        player?.play()
    }
    
    func stopAudioPlayer() {
        player?.stop()
    }

    /* -------------------- SelectedGameDelegate 필수 구현 메서드 ------------------ */
    
    func selectedGameNumber() -> Int {
        return gameNumber
    }
}

