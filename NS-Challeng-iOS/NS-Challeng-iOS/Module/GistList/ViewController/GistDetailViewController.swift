//
//  GistDetail.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class GistDetailViewController: UIViewController {
    
    //MARK: - GistsListViewData
    var viewData: GistsListViewData
    
    //MARK: - Labels
    @IBOutlet weak var imageAuthor: UIImageView!
    @IBOutlet weak var nameAuthorLbl: UILabel!
    @IBOutlet weak var fileType: UILabel!
    @IBOutlet weak var createAtLbl: UILabel!
    @IBOutlet weak var updateAtLbl: UILabel!
    
    
    required init(with data: GistsListViewData) {
        self.viewData = data
        super.init(nibName: "GistDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.nameAuthorLbl.text = viewData.owner.login
        self.fileType.text = "Tipo: " + viewData.files.type
        self.createAtLbl.text = "Data de criação: \n" + viewData.createdAt.dateFormatter()
        self.updateAtLbl.text = "Data de atualização: \n" + viewData.lastUpdate.dateFormatter()
        self.getImage(viewData: viewData)
    }
    
    private func getImage(viewData: GistsListViewData) {
        let isImageCached = ImageCache.default.isCached(forKey: viewData.id)
        if isImageCached {
            ImageCache.default.retrieveImage(forKey: viewData.id, options: nil) { response in
                switch response {
                case .success(let data):
                    self.imageAuthor.image = data.image
                case .failure:
                    return
                }
            }
        } else {
            ImageDownloader.default.downloadImage(with: URL(string: viewData.owner.avatar)!, options: [.preloadAllAnimationData], progressBlock: nil) { response in
                switch response {
                case .success(let data):
                    self.imageAuthor.image = data.image
                    ImageCache.default.store(data.image, forKey: viewData.id)
                case .failure:
                    return
                }
            }
        }
    }
}
