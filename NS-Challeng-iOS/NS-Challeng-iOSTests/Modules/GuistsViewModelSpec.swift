//
//  GuistsViewModelspec.swift
//  NS-Challeng-iOSTests
//
//  Created by Gerson Vieira on 24/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Quick
import Nimble

@testable import NS_Challeng_iOS

class GuistsViewModelspec: QuickSpec {
    var guistsServiceMock: GistsServiceContract!
    var guistsViewModel: GistsViewModel!
    
    override func spec() {
        
        describe("GuistsViewModelspec") {
            beforeEach {
                self.guistsServiceMock = GistsMockService()
                self.guistsViewModel  = GistsViewModel(service: self.guistsServiceMock)
            }
            
            afterEach {
                self.guistsServiceMock = nil
                self.guistsViewModel = nil
            }
            it("testeMockFromService") {
                
                var viewData: [GistsListViewData]? = nil
                let locally: [GistsListViewData] = []
                self.guistsViewModel.fetchList(page: 0, locally: locally) { result in
                    switch result {
                    case .success(let response):
                        viewData = response
                    case .failure:
                        return
                    }
                }
                
                let expectationViewData = 30
                let currentViewDataListCount = viewData?.count ?? -1
                
                expect(viewData).toNot(beNil())
                expect(currentViewDataListCount).to(equal(expectationViewData))
            }
        }
    }
}
