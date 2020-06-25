//
//  GistsFavoriteViewController.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 22/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

class GistsFavoriteViewController: UIViewController {
    
    @IBOutlet weak var gistsListStack: UIStackView!
    
    // MARK: - Properties
    var viewModel: GistsViewModelContract
    var coordinator: FavoriteFlow?
    
    required init(viewModel: GistsViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "GistsFavoriteViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favoritos"
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    func getData() {
        viewModel.getFavorites { result in
            switch result {
            case .success(let data):
                self.loadObjcs(data: data)
            case .failure(let error):
               self.showAlert(title: "Atenção", message: error.localizedDescription)
            }
        }
    }
    // MARK: - UI Setup
    func loadObjcs(data: [GistsListViewData]) {
        self.gistsListStack.removeAllArrangedSubviews()
        for element in data {
            let view =  GistsView(data: element)
            view.selectCallBack { (viewData, action) in
                switch action {
                case .addFavorite:
                    self.viewModel.setDataToSave(data: viewData)
                case .delete:
                    self.viewModel.deleFromDisk(data: viewData)
                    self.getData()
                case .selectStack:
                    self.navigateToDetail(viewData: viewData)
                }
            }
            self.gistsListStack.addArrangedSubview(view)
        }
    }
    
    // MARK: - Actions
    func navigateToDetail(viewData: GistsListViewData) {
        let controller = GistDetailViewController(with: viewData)
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
}
