//
//  BBGameData.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/27.
//

import UIKit

struct BBGameResource {
    private let swipingCatImages:[UIImage] = [#imageLiteral(resourceName: "left"), #imageLiteral(resourceName: "right")]
    private let fishImage: UIImage = #imageLiteral(resourceName: "fish_icon")
    
    func swipingCatImageArray() -> [UIImage] {
        return swipingCatImages
    }
    
    func fishThumbImage() -> UIImage {
        return fishImage
    }
    
    func selectScoreBoardColor(score: Int, highScore: Int) -> [UIColor] {
        var scoreBoardColor: [UIColor] = [.white, .white] // 0 -> backgroundColor, 1 -> textColor
        switch score {
        case score where score < 40:
            let changeIndex = score <= 5 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemRed
            break
        case score where score < 70:
            let changeIndex = score <= 45 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemGreen
            break
        case score where score < 100 || score <= highScore:
            let changeIndex = score <= 75 ? 0 : 1
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
