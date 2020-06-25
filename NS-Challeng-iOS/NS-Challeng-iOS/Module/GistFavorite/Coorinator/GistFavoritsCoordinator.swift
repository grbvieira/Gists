//
//  GistFavoritsCoordinator.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

protocol FavoriteFlow: class {
    func coordinateToTabBar()
}

class GistFavoritsCoordinator: Coordinator, FavoriteFlow {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let provider = MoyaProvider<GistsRouter>()
        let service = GistsService(provider: provider)
        let viewModel = GistsViewModel(service: service)
        let viewController = GistsFavoriteViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        addCoordinate(tabBarCoordinator)
    }
}
