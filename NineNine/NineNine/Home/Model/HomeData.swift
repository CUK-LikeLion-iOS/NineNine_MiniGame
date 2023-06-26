//
//  MainData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct HomeData {
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
