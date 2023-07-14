//
//  TapTapGameData.swift
//  NineNine
//
//  Created by 김희은 on 2023/07/05.
//

import UIKit

struct TapTapGameData {
    private let cheeseButtonImage:[UIImage] = [#imageLiteral(resourceName: "TapTapGame_cheesebtn"), #imageLiteral(resourceName: "TapTapGame_cheesebtn_pushed")]
    private let pushingCatImages:[UIImage] = [#imageLiteral(resourceName: "TapTapGame_cat_mini_before_push"), #imageLiteral(resourceName: "TapTapGame_cat_mini_after_push")]
    
    func cheeseButtonImageArray() -> [UIImage] {
        return cheeseButtonImage
    }
    func pushingCatImageArray() -> [UIImage] {
        return pushingCatImages
    }
    
    
    func selectScoreBoardColor(score: Int, highScore: Int) -> [UIColor] {
        var scoreBoardColor: [UIColor] = [.white, .white] // 0 -> backgroundColor, 1 -> textColor
        switch score {
        case score where score < 40:
            let changeIndex = score <= 5 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemRed
            break
        case score where score < 75:
            let changeIndex = score <= 45 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemGreen
            break
        case score where score < 100 || score <= highScore:
            let changeIndex = score <= 80 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemBlue
            break
        default:
            let changeIndex = score <= highScore + 5 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemPurple
            break
        }
        return scoreBoardColor
    }
}
