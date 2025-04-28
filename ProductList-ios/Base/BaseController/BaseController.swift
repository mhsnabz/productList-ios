//
//  BaseController.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import UIKit
import Combine
class BaseController: UIViewController,LoadingProtocol {
    var cancellabes = Set<AnyCancellable>()
    lazy var animator = CustomProgress()
    
    override func viewDidLoad() {
    }

}
