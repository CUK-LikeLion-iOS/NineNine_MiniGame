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
}
