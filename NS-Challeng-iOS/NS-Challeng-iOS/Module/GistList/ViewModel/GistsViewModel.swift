//
//  GistsViewModel.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

protocol GistsViewModelContract {
    func fetchList(page: Int, locally: [GistsListViewData], completion: @escaping (Result<[GistsListViewData]>) -> Void)
    func getFavorites(completion: @escaping(Result<[GistsListViewData]>) -> Void)
    func setDataToSave(data: GistsListViewData)
    func deleFromDisk(data: GistsListViewData)
}

class GistsViewModel: GistsViewModelContract {
 
    let service: GistsServiceContract
    let storage: StorageProtocol
    
    init(service: GistsServiceContract, storage: StorageProtocol = Storage()) {
        self.service = service
        self.storage = storage
    }
    
    func fetchList(page: Int, locally: [GistsListViewData] ,completion: @escaping (Result<[GistsListViewData]>) -> Void) {
        self.service.fetchList(page: page) { result in
            switch result {
            case .success(let data):
                var builder = GistsBuilder()
                let viewData = builder.set(model: data, locally: locally).build()
                completion(.success(viewData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setDataToSave(data: GistsListViewData) {
        var builder = GistsBuilder()
        let gistData = builder.setDataToSave(data: data).buildGistData()
        self.storage.saveGists(data: gistData)
    }
    
    func getFavorites(completion: @escaping (Result<[GistsListViewData]>) -> Void) {
        self.storage.getSavedGist { result in
            switch result {
            case .success(let data):
                var builder = GistsBuilder()
                let viewData = builder.setFavorite(data: data).build()
                completion(.success(viewData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleFromDisk(data: GistsListViewData) {
        self.storage.deleteGist(data: data)
     }
}
