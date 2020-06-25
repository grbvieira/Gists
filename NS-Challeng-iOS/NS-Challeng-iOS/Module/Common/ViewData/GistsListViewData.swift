//
//  GuistsList.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class GistsListViewData {
    var gistsUrl: String = String()
    var id: String = String()
    var htmlUrl: String = String()
    var files: FileViewData = FileViewData()
    var gistsPublic: Bool = false
    var createdAt: String = String()
    var lastUpdate: String = String()
    var gistsDescription: String = String()
    var comments: Int = 0
    var commnentsUrl: String = String()
    var owner: OwnerViewData = OwnerViewData()
    var favorite: Bool = false
}
