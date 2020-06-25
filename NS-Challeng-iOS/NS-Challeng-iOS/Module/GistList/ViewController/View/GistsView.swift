//
//  GistsView.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Kingfisher

enum ActionCallBack {
    case addFavorite
    case delete
    case selectStack
}
class GistsView: NibView {
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var fileTypeLbl: UILabel!
    @IBOutlet weak var favoriteLbl: UIButton!
    
    var callBack: ((_ viewData: GistsListViewData, _ actionType: ActionCallBack )-> Void)?
    var viewData: GistsListViewData
    required init(data: GistsListViewData) {
        self.viewData = data
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.getImage(viewData: viewData)
        self.nameLbl.text = viewData.owner.login
        self.fileTypeLbl.text = "file type: " + viewData.files.type
        self.setStarColor(favorite: viewData.favorite)
        
        self.avatarImg.layer.borderWidth=1.0
        self.avatarImg.layer.masksToBounds = false
        self.avatarImg.layer.borderColor = UIColor.white.cgColor
        self.avatarImg.layer.cornerRadius = self.avatarImg.frame.size.height/2
        self.avatarImg.clipsToBounds = true
    }
    
    func setStarColor(favorite: Bool) {
        if favorite {
            self.favoriteLbl.setImage(UIImage(named: "star"), for: .normal)
        } else {
            switch self.traitCollection.userInterfaceStyle {
            case .unspecified:
                self.favoriteLbl.setImage(UIImage(named: "star_outline"), for: .normal)
            case .light:
                self.favoriteLbl.setImage(UIImage(named: "star_outline"), for: .normal)
            case .dark:
                self.favoriteLbl.setImage(UIImage(named: "star_white_outline"), for: .normal)
            @unknown default:
                self.favoriteLbl.setImage(UIImage(named: "star_outline"), for: .normal)
            }
        }
    }
    
    func selectCallBack(callback: ((_ viewData: GistsListViewData, _ actionType: ActionCallBack) -> Void)? = nil) {
        if let cb = callback {
            self.callBack = cb
        }
    }
    
    func getImage(viewData: GistsListViewData) {
        let isImageCached = ImageCache.default.isCached(forKey: viewData.id)
        if isImageCached {
            ImageCache.default.retrieveImage(forKey: viewData.id, options: nil) { response in
                switch response {
                case .success(let data):
                    self.avatarImg.image = data.image
                case .failure:
                    return
                }
            }
        } else {
            ImageDownloader.default.downloadImage(with: URL(string: viewData.owner.avatar)!, options: [.preloadAllAnimationData], progressBlock: nil) { response in
                switch response {
                case .success(let data):
                    self.avatarImg.image = data.image
                    ImageCache.default.store(data.image, forKey: viewData.id)
                case .failure:
                    return
                }
            }
        }
    }
    
    
    @IBAction func selectGist(_ sender: Any) {
        guard let cb = self.callBack else { return }
        cb(self.viewData, .selectStack)
    }
    
    @IBAction func addFavoritesAction(_ sender: Any) {
        guard let cb = self.callBack else { return }
        self.favoriteLbl.setImage(UIImage(named: "star"), for: .normal)
        if self.viewData.favorite {
            self.setStarColor(favorite: false)
            cb(self.viewData, .delete)
        } else {
            cb(self.viewData, .addFavorite)
        }
    }
    
}
