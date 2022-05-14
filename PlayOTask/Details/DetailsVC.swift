//
//  DetailsVC.swift
//  PlayOTask
//
//  Created by sunil biloniya on 14/05/22.
//

import UIKit
import WebKit

class DetailsVC: UIViewController {
    // MARK: OUTLETS
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: VARIABLES
    var url: String = ""
    
    // MARK: VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWeb()
    }
    // MARK: CUSTOM METHODS
    private func loadWeb(){
        self.startLoading()
        self.webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: url)!)
        webView.load(request)
    }
    // MARK: IBACTIONS
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
// MARK: WKNAVIGATION DELEGATE
extension DetailsVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopLoading()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.stopLoading()
    }
}
