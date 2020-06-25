//
//  Result.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation
enum Result<T> {
    case success(T)
    case failure(Error)
}
