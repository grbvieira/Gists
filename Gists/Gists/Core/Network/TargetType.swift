//
//  TargetType.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Moya

enum Paths: String {
    case gistsPublic = "gists/public"
}

enum Keys: String {
    case page = "page"
}


extension TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://api.github.com/")!
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return ["":""]
    }
}
