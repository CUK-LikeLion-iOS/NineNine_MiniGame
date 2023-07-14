//
//  GameReadyData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct GameResource {
    private let gameInformationList: [(String, String)] = [
        ("탭탭", "화면에 있는 치즈 버튼을\n10초동안\n마구마구 누르세요!."),
        ("쉐킷쉐킷", "휴대폰을 마음껏 흔들어주세요!\n너무 열심히 흔든 나머지\n휴대폰이 날아가지 않도록 주의하세요."),
        ("부비부비", "화면의 생선을 누른 상태로\n좌우로 마구마구 비벼주세요!\n고양이를 생선으로 재미있게 놀아주세요!"),
        ("더하기를 하자!", "최대한 빠르게\n덧셈에 대한 정답을\n입력해주세요!"),
        ("곱하기를 하자!", "최대한 빠르게\n곱셈에 대한 정답을\n입력해주세요!")
    ]
    private let gameStoryBoardAndViewControllerList: [(String, String)] = [
        ("TabTabGame", "TabTabGameViewController"),
        ("ShakeItGame", "ShakeItGameViewController"),
        ("BBGame", "BBGameViewController"),
        ("PlusGame", "PlusGameViewController"),
        ("MultiplyGame", "MultiplyGameViewController")
    ]
    private let gameTitles: [String] = ["TabTabGame", "ShakeItGame", "BBGame", "PlusGame", "MultiplyGame"]
    private let gameRankImageList = [#imageLiteral(resourceName: "1_bad_score_board"), #imageLiteral(resourceName: "2_good_score_board"), #imageLiteral(resourceName: "3_great_score_board"), #imageLiteral(resourceName: "4_best_score_board")]

    func gameInformation() -> [(String, String)] {
        return gameInformationList
    }
    
    func gameTitleList() -> [String] {
        return gameTitles
    }
    
    func gameStoryBoardAndViewControllers() -> [(String, String)] {
        return gameStoryBoardAndViewControllerList
    }
    
    func gameRankImages() -> [UIImage] {
        return gameRankImageList
    }
}
