//
//  CoordinatorSpec.swift
//  NS-Challeng-iOSTests
//
//  Created by Gerson Vieira on 23/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble

@testable import NS_Challeng_iOS

class CoordinatorSpec: QuickSpec {
    
    var appCoordinator: AppCoordinator!
    var defaultWindow: UIWindow!
    
    override func spec() {
        
        describe("CoordinatorSpec"){
            beforeEach {
                self.defaultWindow = UIWindow()
                self.appCoordinator = AppCoordinator(window: self.defaultWindow)
                self.appCoordinator?.start()
            }
            
            afterEach {
                self.appCoordinator = nil
            }
            
            it ("testAddSameCoordinator") {
                let newCoordinator = AppCoordinator(window: self.defaultWindow)
                self.appCoordinator.addCoordinate(newCoordinator)
                
                let countChildCoordinator = self.appCoordinator.childCoordinators.count
                self.appCoordinator.addCoordinate(newCoordinator)
                
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                expect(countChildCoordinator).to(equal(newCountChildCoordinators))
            }
            
            it("Remove child Coordinator") {
                let newCoordinator = AppCoordinator(window: self.defaultWindow)
                self.appCoordinator.addCoordinate(newCoordinator)
                let countChildCoordinators = self.appCoordinator.childCoordinators.count
                
                self.appCoordinator.removeChildCoordinator(newCoordinator)
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                expect(newCountChildCoordinators).to(equal(countChildCoordinators  - 1))
                
            }
            
            it("Remoce child coordinator emptyList") {
                let newCoordinator = AppCoordinator(window: self.defaultWindow)
                let countChildCoordinators = self.appCoordinator.childCoordinators.count
                
                self.appCoordinator.removeChildCoordinator(newCoordinator)
                let newCountChildCoordinators = self.appCoordinator.childCoordinators.count
                
                expect(newCountChildCoordinators).to(equal(countChildCoordinators))
            }
        }
        
    }
}
