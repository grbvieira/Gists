//
//  Decodable+Extension.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
extension Decodable {
    static var className: String {
        return String(describing: type(of: self))
    }
}
