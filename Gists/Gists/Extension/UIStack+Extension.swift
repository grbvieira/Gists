//
//  UIStack+Extension.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 24/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubviews() {
        self.subviews.forEach({
            $0.removeFromSuperview()
        })
    }
}
