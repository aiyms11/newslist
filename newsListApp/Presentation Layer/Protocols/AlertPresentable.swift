//
//  AlertPresentable.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/29/21.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String, message: String?, submitTitle: String, completion: @escaping () -> ())
    func showErrorAlert(_ error: Error)
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String?, submitTitle: String = "ok".localized, completion: @escaping () -> () = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: submitTitle, style: .default) { _ in
            completion()
        }
        alertController.addAction(action)

        self.present(alertController, animated: true, completion: nil)
    }

    func showErrorAlert(_ error: Error) {
        showAlert(title: "error".localized, message: error.localizedDescription)
    }
}

