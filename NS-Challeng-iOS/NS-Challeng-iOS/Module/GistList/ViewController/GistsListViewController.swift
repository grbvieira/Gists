//
//  GistsListViewController.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 21/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import Moya

class GistsListViewController: UIViewController {
    
    @IBOutlet weak var stackList: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var fetching = false
    private var viewModel: GistsViewModelContract
    private var locally: [GistsListViewData] = []
    private var page: Int = 0
    
    var coordinator: GistsList?
    
    required init(viewModel: GistsViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "GistsListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lista de Gists"
        self.stackList.removeAllArrangedSubviews()
        self.scrollView.delegate = self
        self.getDataOffline()
        self.fetch()
    }
    
    private func fetch() {
        fetching = true
        self.activityIndicator()
        self.viewModel.fetchList(page: page, locally: locally) { result in
            switch result {
            case .success(let response):
                self.fetching = false
                self.loadObjcs(data: response)
            case .failure(let error):
                self.fetching = false
                self.showAlert(title: "Atenção", message: error.localizedDescription)
            }
        }
    }
    
    private func getDataOffline() {
        viewModel.getFavorites { result in
            switch result {
            case .success(let data):
                self.locally = data
            case .failure:
                return
            }
        }
    }
    
    // MARK: - UI Setup
    private func loadObjcs(data: [GistsListViewData]) {
        self.removeLoadView()
        for element in data {
            let view = GistsView(data: element)
            view.selectCallBack { (viewData, action) in
                switch action {
                case .addFavorite:
                    self.viewModel.setDataToSave(data: viewData)
                case .delete:
                    self.viewModel.deleFromDisk(data: viewData)
                case .selectStack:
                    self.nagivateToDetail(data: viewData)
                }
            }
            self.stackList.addArrangedSubview(view)
        }
    }
    
    private func activityIndicator() {
        let loadingView = UIActivityIndicatorView()
        loadingView.color = .black
        loadingView.startAnimating()
        stackList.addArrangedSubview(loadingView)
    }
    
    func removeLoadView() {
        self.stackList.subviews.forEach({
            if $0 is UIActivityIndicatorView {
                $0.removeFromSuperview()
            }
        })
    }
    
    
    // MARK: - Actions
    @objc
    func showGistList(_ sender: UIButton) {
        coordinator?.coordinateToTabBar()
    }
    
    func nagivateToDetail(data: GistsListViewData) {
        let controller = GistDetailViewController(with: data)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension GistsListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
            if !fetching {
                page = page + 1
                self.fetch()
            }
        }
    }
}
