//
//  GistsMockService.swift
//  NS-Challeng-iOSTests
//
//  Created by Gerson Vieira on 24/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya
import UIKit
@testable import NS_Challeng_iOS

class GistsMockService: GistsServiceContract {
    
    var provider: MoyaProvider<GistsRouter> = MoyaProvider<GistsRouter>()
    
    func fetchList(page: Int, completion: @escaping (Result<[GistsResponse]>) -> Void) {
        guard let response = LoadJson.loadJson(filename: "GistsMockReponse", modelType: [GistsResponse].self) else { fatalError("Não foi possivel ler o json") }
        completion(.success(response))
    }
    
    
}
