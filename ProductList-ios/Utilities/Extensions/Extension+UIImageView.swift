//
//  Extension+UIImageView.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit
import SDWebImage
extension UIImageView {
    func loadImage(_ url: String?) {
        guard let stringUrl = url , let URL = URL(string: stringUrl) else { return }
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL, placeholderImage: UIImage(named: "placeholder") ?? UIImage())
    }
}
