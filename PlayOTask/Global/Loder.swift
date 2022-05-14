//
//  Loder.swift
//  PlayOTask
//
//  Created by sunil biloniya on 14/05/22.
//

import Foundation
import UIKit
extension UIViewController {
    static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    public func startLoading() {
        let activityIndicator = UIViewController.activityIndicator
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

   public func stopLoading() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        UIApplication.shared.endIgnoringInteractionEvents()
      }
}
