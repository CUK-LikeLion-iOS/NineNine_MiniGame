//
//  MultiplyModel.swift
//  NineNine
//
//  Created by 김정원 on 2023/07/07.
//

import UIKit
struct PlusGameData {
    private let numberImage : UIImage = #imageLiteral(resourceName: "전체숫자판")
    private let homeImage : UIImage = #imageLiteral(resourceName: "MultiplyeGame_start_cat")

    func catImage() -> UIImage {
        return homeImage
    }
    func answerImage () -> UIImage {
        return numberImage
    }
}
