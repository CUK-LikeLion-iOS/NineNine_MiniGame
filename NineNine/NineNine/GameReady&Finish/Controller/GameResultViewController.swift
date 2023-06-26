//
//  BBGameResultViewController.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/06/24.
//

import UIKit

class GameResultViewController: UIViewController {

    @IBOutlet weak var score: UILabel!
    weak var delegate: GameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        score.text = "\(delegate?.showGameResult() ?? 0)"
    }

}
