//
//  GistsListCoordinator.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya


protocol GistsList: class {
    func coordinateToTabBar()
}

class GistsListCoordinator: Coordinator, GistsList {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let provider = MoyaProvider<GistsRouter>()
        let service = GistsService(provider: provider)
        let viewModel = GistsViewModel(service: service)
        let viewController = GistsListViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        addCoordinate(tabBarCoordinator)
    }
}
