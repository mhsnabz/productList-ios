//  ProductDetailVC.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  

import UIKit
import Combine

final class ProductDetailVC: BaseController, ControllerCombineBehaviorallyWithoutComponent {
    typealias V = ProductDetailVM
    private var vm: V?
    
    // Combine operations Binding
    private let inputVM = PassthroughSubject<ProductDetailVMImpl.ProductDetailVMInput, Never>()
    private let productId: Int
    // UI Ref
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        inputVM.send(.start)
    }

    init(productId: Int) {
        self.productId = productId
        super.init(nibName: ProductDetailVC.classname, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inject(vm: V) {
        self.vm = vm
    }
}

// MARK: - Binding
extension ProductDetailVC {
    func binding() {
        // Pr Event Binding
        let output = vm?.activityHandler(input: inputVM.eraseToAnyPublisher())
        output?.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] event in // If not needed, DispatchQueue.main can be removed.
            switch event {
            default: break
            }
        }).store(in: &cancellabes)
    }
}
