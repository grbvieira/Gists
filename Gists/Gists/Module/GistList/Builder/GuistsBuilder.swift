//
//  GuistsBuilder.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

protocol GistsBuilderProtocol {
    mutating func set(model: [GistsResponse], locally: [GistsListViewData]) -> Self
    func build() -> [GistsListViewData]
    var gistsViewData: [GistsListViewData]! { get set }
}

extension GistsBuilderProtocol {
    
    mutating func set(model: [GistsResponse], locally: [GistsListViewData]) -> Self {
        gistsViewData = getGists(model: model, locally: locally)
        return self
    }
    
    func getGists(model: [GistsResponse], locally: [GistsListViewData]) -> [GistsListViewData] {
        var viewDataArray: [GistsListViewData] = []
        for element in model {
            let viewData = GistsListViewData()
            let filesViewData = FileViewData()
            let ownerViewData = OwnerViewData()
            viewData.gistsUrl = element.url ?? String()
            viewData.id = element.id ?? String()
            viewData.htmlUrl = element.htmlURL ?? String()
            viewData.gistsPublic = element.gistsPublic ?? false
            viewData.createdAt =   element.createdAt ?? String()
            viewData.lastUpdate = element.updatedAt ?? String()
            viewData.gistsDescription = element.welcomeDescription ?? String()
            viewData.comments = element.comments ?? 0
            viewData.favorite = self.checksFavorite(id: element.id ?? String(), data: locally)
            if let commentsURL = element.commentsURL{
                viewData.commnentsUrl =  commentsURL
            }
            
            let files = getFiles(data: element.files!)
            if !files.isEmpty {
                filesViewData.filename = files[0].files.filename
                filesViewData.language = files[0].files.language ?? String()
                filesViewData.size = files[0].files.size
                filesViewData.type = files[0].files.type
            }
            
            
            if let owner = element.owner {
                ownerViewData.login = owner.login ?? String()
                ownerViewData.id =  owner.id ?? 0
                if let avatarURL = owner.avatarURL {
                    ownerViewData.avatar = avatarURL
                }
                
                if let url =  element.owner?.url {
                    ownerViewData.profileURL = url
                }
                
                if let gistsURL =  element.owner?.gistsURL {
                    ownerViewData.gistsURL =   gistsURL
                }
                
                if let reposURL =  element.owner?.reposURL {
                    ownerViewData.repo =  reposURL
                }
                
            }
            viewData.files = filesViewData
            viewData.owner = ownerViewData
            viewDataArray.append(viewData)
        }
        
        return viewDataArray
    }
    
    func getFiles(data: [String: File]) -> [FileExtract] {
        return data.compactMap { element in
            let format = FileExtract(key: element.key, file: element.value)
            return format
        }
    }
    
    func checksFavorite(id: String, data: [GistsListViewData]) -> Bool {
        for element in data {
            if element.id == id {
                return true
            }
        }
        return false
    }
    
    func build() -> [GistsListViewData] {
        return gistsViewData
    }
}

//MARK: - Builder
struct GistsBuilder: GistsBuilderProtocol {
    var gistLocally: GistsData!
    var gistsViewData: [GistsListViewData]!
    
    init() {
        gistsViewData = []
        gistLocally = GistsData()
    }
}
