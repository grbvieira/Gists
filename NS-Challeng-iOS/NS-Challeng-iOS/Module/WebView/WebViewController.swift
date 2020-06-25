//
//  WebViewController.swift
//  NS-Challeng-iOS
//
//  Created by Gerson Vieira on 25/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var optionWebView: WKWebView!
    var urlReceive: String?
    
    required init(with urlReceive: String) {
        super.init(nibName: "WebViewController", bundle: nil)
        self.urlReceive = urlReceive
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlReceive = urlReceive else {
            self.showAlert(title: "Atenção", message: "erro ao carregar webview")
            return
        }
        optionWebView.load(URLRequest(url: URL(string: urlReceive)!))
    }
    
}
