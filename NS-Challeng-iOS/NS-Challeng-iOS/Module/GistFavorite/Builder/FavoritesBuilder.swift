//
//  FavoritesBuilder.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

protocol FavoritesBuilderProtocol {
    mutating func setDataToSave(data: GistsListViewData) -> Self
    mutating func setFavorite(data: [GistsData]) -> Self
    var gistsViewData: [GistsListViewData]! { get set }
    var gistLocally: GistsData! { get set }
}

extension FavoritesBuilderProtocol {
    mutating func setDataToSave(data: GistsListViewData) -> Self {
        gistLocally = getDataToSave(data: data)
        return self
    }
    
    mutating func setFavorite(data: [GistsData]) -> Self {
        gistsViewData = getFavoriteGists(data: data)
        return self
    }
    
    func getFavoriteGists(data: [GistsData]) -> [GistsListViewData] {
        var viewDataArray: [GistsListViewData] = []
        for element in data {
            let viewData = GistsListViewData()
            let filesViewData = FileViewData()
            let ownerViewData = OwnerViewData()
            viewData.gistsUrl = element.gistsUrl ?? String()
            viewData.id = element.id ?? String()
            viewData.htmlUrl = element.htmlUrl!
            viewData.gistsPublic = element.gistsPublic
            viewData.createdAt = element.createdAt ?? String()
            viewData.lastUpdate = element.lastUpdate ?? String()
            viewData.gistsDescription = element.gistsDescription ?? String()
            viewData.comments = Int(element.comments)
            viewData.favorite = true
            if let commentsURL = element.commnentsUrl {
                viewData.commnentsUrl =  commentsURL
            }
            
            if let files = element.files {
                filesViewData.filename = files.filename ?? String()
                filesViewData.language = files.language ?? String()
                filesViewData.size = Int(files.size)
                filesViewData.type = files.type ?? String()
            }
            
            if let owner = element.owner {
                ownerViewData.login = owner.login ?? String()
                ownerViewData.id =  Int(owner.id)
                ownerViewData.profileURL =  owner.profileURL ?? String()
                ownerViewData.gistsURL = owner.gistsURL ?? String()
                ownerViewData.repo =   owner.repo ?? String()
            }
            viewData.files = filesViewData
            viewData.owner = ownerViewData
            viewDataArray.append(viewData)
        }
        
        return viewDataArray
    }
    
    func getDataToSave(data: GistsListViewData) -> GistsData {
        var managedContext: NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
        
        let gist = GistsData(context: managedContext)
        let owner = OwnerGist(context: managedContext)
        let files = FilesData(context: managedContext)
        gist.gistsUrl = data.gistsUrl
        gist.id = data.id
        gist.htmlUrl = data.htmlUrl
        gist.gistsPublic = data.gistsPublic
        gist.createdAt =   data.createdAt
        gist.lastUpdate = data.lastUpdate
        gist.gistsDescription = data.gistsDescription
        //  gist.comments = Int64(data.comments)
        gist.favorite = true
        gist.commnentsUrl =  data.commnentsUrl
        files.filename = data.files.filename
        files.language = data.files.language
        files.size = Int64(data.files.size)
        files.type = data.files.type
        owner.avatar = data.owner.avatar
        owner.login = data.owner.login
        owner.id = Int64(data.owner.id)
        owner.profileURL = data.owner.profileURL
        owner.gistsURL =   data.owner.gistsURL
        owner.repo =   data.owner.repo
        gist.files = files
        gist.owner = owner
        
        return gist
    }
    
    func build() -> [GistsListViewData] {
        return gistsViewData
    }
    
    func buildGistData() -> GistsData {
        return gistLocally
    }
}

//MARK: - Builder
struct FavoritesBuilder: FavoritesBuilderProtocol {
    var gistLocally: GistsData!
    var gistsViewData: [GistsListViewData]!
    
    init() {
        gistsViewData = []
        gistLocally = GistsData()
    }
}
