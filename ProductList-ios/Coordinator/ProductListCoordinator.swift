//
//  ProductListCoordinator.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
class ProductDetailCoordinator: Coordinator {
    override func start(id: Int) {
        let vc = ProductDetailBuilderImpl().build(id: id)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
