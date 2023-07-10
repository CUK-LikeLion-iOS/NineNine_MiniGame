//
//  SetViewRoundShape.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/23.
//

import UIKit

func makeCornerRoundShape(targetView: UIView, cornerRadius: CGFloat) {
    targetView
        .layer.cornerRadius = cornerRadius
    targetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
}

func countDownBeforeGame(countDownView view: UIView) {
    var timer: Timer?
    guard let label = view.subviews.first as? UILabel else {
        print("무조건 하위 뷰 객체들 중 첫 번째가 카운트다운 Label이어야함!!")
        return
    }
    var sec: Int = 1
    
    guard label.text != nil else { return }
    
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
        if (sec == 3) {
            timer.invalidate()
            view.isHidden = true
        }
        label.text = "\(3 - sec)"
        sec += 1
    })
}
