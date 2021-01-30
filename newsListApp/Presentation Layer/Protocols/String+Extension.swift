//
//  String+Extension.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/29/21.
//

import Foundation

extension String {
    var localized: String {
        return Bundle.main.localizedString(forKey: self, value: "", table: "")
    }
}
