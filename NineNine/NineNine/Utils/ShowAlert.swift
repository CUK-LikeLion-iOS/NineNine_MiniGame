//
//  ShowAlert.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/07/03.
//

import UIKit

func showAlert(title: String, content:String, vc: UIViewController) {
    let alert = UIAlertController(title: title, message: content, preferredStyle: UIAlertController.Style.alert)

    let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            // [확인 버튼 클릭 이벤트 내용 정의 실시]
            return
        }
    alert.addAction(okAction)
    vc.present(alert, animated: false, completion: nil)
}
