//
//  Coordinator.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

protocol Coordinator: class {
     var childCoordinators: [Coordinator] { get set }
    func start()
    func addCoordinate(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
    func addCoordinate(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
