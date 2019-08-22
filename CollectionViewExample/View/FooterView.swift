//
//  FooterView.swift
//  CollectionViewExample
//
//  Created by 최민섭 on 22/08/2019.
//  Copyright © 2019 최민섭. All rights reserved.
//

import UIKit

enum ButtonState {
    case plus
    case minus
}

class FooterView: UICollectionReusableView {
    var action = { (state: ButtonState) in }
    @IBAction func touchupMinusButton(_ sender: Any) {
        action(.minus)
    }
    @IBAction func touchUpPlusButton(_ sender: Any) {
        action(.plus)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        self.sendSubviewToBack(blurEffectView)
    }
    
}
