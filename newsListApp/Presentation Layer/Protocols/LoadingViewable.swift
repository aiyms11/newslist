//
//  LoadingViewable.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/29/21.
//

import Foundation
import UIKit

protocol LoadingViewable {
    var activityIndicator: UIActivityIndicatorView { get }
    func showLoader()
    func hideLoader()
}

extension LoadingViewable where Self: UIViewController  {
    
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.activityIndicator.center = CGPoint(x:self.view.bounds.size.width / 2, y:self.view.bounds.size.height / 2)
                self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
