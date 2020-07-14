//
//  TabBarCoordinator.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let gistListNavigationController = UINavigationController()
        gistListNavigationController.tabBarItem = UITabBarItem(title: "Lista", image: UIImage(named: "list_tabbar"), tag: 0)
        let gistListCoordinator = GistsListCoordinator(navigationController: gistListNavigationController)
        
        
        let favoriteNavigationController = UINavigationController()
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "star_tabbar"), tag: 1)
        let favoriteCoordinator = GistFavoritsCoordinator(navigationController: favoriteNavigationController)
        
        tabBarController.viewControllers = [gistListNavigationController,
                                            favoriteNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: true, completion: nil)
        
        addCoordinate(gistListCoordinator)
        addCoordinate(favoriteCoordinator)
    }
}

