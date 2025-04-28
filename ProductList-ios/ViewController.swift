//
//  ViewController.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import UIKit

class ViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        self.loading(isShow: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.loading(isShow: false)
        })
    }

}
