//
//  NSDate+Extension.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation

extension NSDate {
    func getDateFormatter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
}
