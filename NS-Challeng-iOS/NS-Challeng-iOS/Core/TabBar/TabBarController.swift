//
//  TabBarController.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = UIColor.tertiarySystemBackground
        self.tabBar.tintColor = UIColor.secondarySystemBackground
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    var coordinator: TabBarCoordinator?
}

