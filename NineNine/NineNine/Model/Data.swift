//
//  GameData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/21.
//

import UIKit

struct MainData {
    private let gameTitles: [String] = ["탭탭!", "쉐킷쉐킷!", "부비부비"]
    private let gameImages: [UIImage] = [#imageLiteral(resourceName: "tabtab"), #imageLiteral(resourceName: "Shake"), #imageLiteral(resourceName: "swipe")]
    private let gameStoryboardIDs: [String] = ["TTStartingVC", "ShShStartingVC", "BBStartingVC", "PlusStartingVC", "MultiplyStartingVC"]
    
    func gameTitleArray() -> [String] {
        return gameTitles
    }
    
    func gameImageArray() -> [UIImage] {
        return gameImages
    }
    
    func gameStoryboardIDArray() -> [String] {
        return gameStoryboardIDs
    }
}

struct BBGameData {
    private let swipingCatImages:[UIImage] = [#imageLiteral(resourceName: "left"), #imageLiteral(resourceName: "right")]
    private let fishImage: UIImage = #imageLiteral(resourceName: "fish_icon")
    private let gameStartBtnImages: [UIImage] = [#imageLiteral(resourceName: "GameStartBtn2"), #imageLiteral(resourceName: "GameStartBtn")]
    
    func swipingCatImageArray() -> [UIImage] {
        return swipingCatImages
    }
    
    func fishThumbImage() -> UIImage {
        return fishImage
    }
    
    func gameStartBtnImageArray() -> [UIImage] {
        return gameStartBtnImages
    }
}

