//
//  Coordinator.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit

class Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ProductListBuilderImpl().build()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func start(id: String) { }
}
