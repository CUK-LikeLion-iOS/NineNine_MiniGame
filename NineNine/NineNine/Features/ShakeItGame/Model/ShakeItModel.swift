//
//  ShakeItModel.swift
//  NineNine
//
//  Created by Demian on 2023/07/02.
//

import UIKit

struct ShakeItGameData {
    private let catImage: [UIImage] = [#imageLiteral(resourceName: "ShakeItGame_before_2"), #imageLiteral(resourceName: "ShakeItGame_after_2")]
    
    func readyCatImage() -> UIImage {
        return catImage[0]
    }
    
    func shakingCatImage() -> UIImage {
        return catImage[1]
    }
    
    
    func selectScoreBoardColor(score: Int, highScore: Int) -> [UIColor] {
        var scoreBoardColor: [UIColor] = [.white, .white, .white] // 0 -> backgroundColor, 1 -> textColor
        switch score {
        case score where score < 20:
            let changeIndex = score <= 5 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemRed
            scoreBoardColor[2] = .systemRed
            break
        case score where score < 50:
            let changeIndex = score <= 25 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemGreen
            scoreBoardColor[2] = .systemGreen
            break
        case score where score < 80 || score < highScore:
            let changeIndex = score <= 55 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemBlue
            scoreBoardColor[2] = .systemBlue
            break
        default:
            let changeIndex = score <= highScore + 5 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemPurple
            scoreBoardColor[2] = .systemPurple
            break
        }
        return scoreBoardColor
    }
}
