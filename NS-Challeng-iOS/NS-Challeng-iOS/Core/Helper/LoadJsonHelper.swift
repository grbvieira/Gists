//
//  LoadJsonHelper.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 24/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation

public class LoadJson {
    
    static func loadJson<T: Decodable>(filename: String, modelType: T.Type) -> T? {
        if let data = HelperJson.shared.openFile(withName: filename) {
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(modelType, from: data)
                return jsonData
            } catch {
                print("error: \(error)")
            }
        }
        return nil
    }
}

class HelperJson {
    static let shared = HelperJson()
    
    internal func openFile(withName filename: String, ext: String = "json") -> Data? {
        guard let path = Bundle(for: type(of: self)).path(forResource: filename, ofType: ext) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }
        return data
    }
}
