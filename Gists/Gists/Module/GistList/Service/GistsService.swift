//
//  GistsService.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

protocol GistsServiceContract {
    var provider: MoyaProvider<GistsRouter> { get set }
    func fetchList(page: Int, completion: @escaping(Result<[GistsResponse]>) -> Void)
}

class GistsService: GistsServiceContract {
    
    var provider: MoyaProvider<GistsRouter>
    
    init(provider: MoyaProvider<GistsRouter>) {
        self.provider = provider
    }
    
    func fetchList(page: Int, completion: @escaping (Result<[GistsResponse]>) -> Void) {
        provider.request(.gistsPublic(page)) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map([GistsResponse].self, atKeyPath: nil, using: JSONDecoder())
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
     } 
}

extension Data {
    var prettyPrinted: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else
        { return nil }
        return string
    }
}
