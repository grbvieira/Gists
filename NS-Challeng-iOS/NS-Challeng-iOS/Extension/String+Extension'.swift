//
//  String+Extension'.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

extension String {
    func dateFormatter() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "dd/MM/yyyy"
            return formatter.string(from: date)
        }
        return self
    }
}
