//
//  StorageProtocol.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import CoreData

protocol StorageProtocol {
    func saveGists(data: GistsData)
    func getSavedGist(completion: @escaping (Result<[GistsData]>) -> Void) 
    func deleteGist(data: GistsListViewData)
}
