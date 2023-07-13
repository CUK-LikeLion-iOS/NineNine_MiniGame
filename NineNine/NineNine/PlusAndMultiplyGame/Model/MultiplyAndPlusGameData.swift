//
//  MultiplyModel.swift
//  NineNine
//
//  Created by 김정원 on 2023/07/07.
//

import UIKit
struct MultiplyAndPlusGameData {
    private let numberImage : UIImage = #imageLiteral(resourceName: "전체숫자판")
    private let multiplyHomeImage : UIImage = #imageLiteral(resourceName: "MultiplyeGame_start_cat")
    private let plusHomeImage : UIImage = #imageLiteral(resourceName: "PlusGame_start_cat")

    func multiplyCatImage() -> UIImage {
        return multiplyHomeImage
    }
    func plusCatImage() -> UIImage {
        return plusHomeImage
    }
    func answerImage () -> UIImage {
        return numberImage
    }
    func selectScoreBoardColor(score: Int, highScore: Int) -> [UIColor] {
        var scoreBoardColor: [UIColor] = [.white, .white] // 0 -> backgroundColor, 1 -> textColor
        switch score {
        case score where score <= 2:
            let changeIndex = score <= 1 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemRed
            break
        case score where score <= 5:
            let changeIndex = score <= 3 ? 0 : 1
            scoreBoardColor[changeIndex] = .systemGreen
            break
        case score where score <= 8 || score <= highScore:
            let changeIndex = score <= 6 ? 0 : 1
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
