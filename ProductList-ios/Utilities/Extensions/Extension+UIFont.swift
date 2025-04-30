//
//  Extension+UIFont.swift
//  ProductList-ios
//
//  Created by srbrt on 30.04.2025.
//

import Foundation
import UIKit
extension UIFont {
    enum AppFonts {
        static let boldFont = UIFont(name: "AvenirNext-DemiBold", size: 24) ?? .systemFont(ofSize: 24, weight: .semibold)
        static let mediumFont = UIFont(name: "AvenirNext-Medium", size: 14) ?? .systemFont(ofSize: 12, weight: .medium)
        static let regularFont = UIFont(name: "AvenirNext-Regular", size: 14) ?? .systemFont(ofSize: 12, weight: .regular)
    }
}
