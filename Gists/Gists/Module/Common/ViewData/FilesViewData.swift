//
//  FilesViewData.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 24/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import Foundation

class FileExtract {
    var key: String
    var files: File
    init(key: String, file: File) {
        self.key = key
        self.files = file
    }
}

class FileViewData {
    var filename: String = String()
    var language: String = String()
    var type: String = String()
    var size: Int = 0
}
