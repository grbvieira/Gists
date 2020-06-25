//
//  GistsRouter.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya

enum GistsRouter {
    case gistsPublic(Int)
}

extension GistsRouter: TargetType {
    var path: String {
        switch self {
        case .gistsPublic:
            return Paths.gistsPublic.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .gistsPublic:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .gistsPublic(let page):
            var parameters: [String: Any] = [:]
            parameters[Keys.page.rawValue] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    var headers: [String : String]? {
        switch self {
        case .gistsPublic:
            return ["content-type": "application/json"]
        }
    }
    
}
