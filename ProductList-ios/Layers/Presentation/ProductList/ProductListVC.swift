//  ProductListVC.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  

import UIKit
import Combine

final class ProductListVC: BaseController, ControllerCombineBehaviorally {
    typealias P = ProductListProvider
    typealias V = ProductListVM
    typealias C = UICollectionView
    private var vm: V?
    private var pr: (any P)?
    
    // Combine operations Binding
    private let inputVM = PassthroughSubject<ProductListVMImpl.ProductListVMInput, Never>()
    private let inputPR = PassthroughSubject<ProductListProviderImpl.ProductListProviderInput, Never>()
    
    // UI Ref
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        inputPR.send(.setupUI(collectionView: collectionView))
        inputVM.send(.start)
    }

    func inject(vm: V, provider: any P) {
        self.vm = vm
        self.pr = provider
    }
}

// MARK: - Binding
extension ProductListVC {
    func binding() {
        // VM Event Binding
        let output = vm?.activityHandler(input: inputVM.eraseToAnyPublisher())
        output?.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] event in
            switch event {
            case .updateUI(sections: let section):
                Logger.d(message: "section :\(section)")
                self?.inputPR.send(.prepareCollectionView(data: section))
            case .error(error: let error):
                Logger.e(message: error.localizedDescription)
            case .isLoading(isShow: let isShow):
                self?.loading(isShow: isShow)
            default: break
            }
        }).store(in: &cancellabes)
        
        // Provider Event Binding
        let providerOutput = pr?.activityHandler(input: inputPR.eraseToAnyPublisher())
        providerOutput?.sink(receiveValue: { [weak self] event in
            switch event {
            default: break
            }
        }).store(in: &cancellabes)
    }
}
