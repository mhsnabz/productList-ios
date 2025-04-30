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
    private let userInteraction = PassthroughSubject<UserInteraction,Never>()
    // UI Ref
    @IBOutlet private weak var collectionView: UICollectionView!
    
    enum UserInteraction {
        case didSelectProduct(id: Int)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        inputPR.send(.setupUI(collectionView: collectionView))
        inputPR.send(.setupUserInteraction(intreaction: userInteraction))
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
            guard let self else { return }
            switch event {
            case .updateUI(sections: let section):
                Logger.d(message: "section :\(section)")
                self.inputPR.send(.prepareCollectionView(data: section))
            case .error(error: let error):
                self.showSimpleAlert(title: "Hata", message: error.localizedDescription, on: self)
            case .isLoading(isShow: let isShow):
                self.loading(isShow: isShow)
            }
        }).store(in: &cancellabes)
        
        // Provider Event Binding
        let providerOutput = pr?.activityHandler(input: inputPR.eraseToAnyPublisher())
        providerOutput?.sink(receiveValue: { _ in
        }).store(in: &cancellabes)
        
        userInteraction.sink {[weak self] eventType in
            guard let self else { return }
            switch eventType {
            case .didSelectProduct(let id):
                let productDetailCoordinator = ProductDetailCoordinator(navigationController: self.navigationController)
                productDetailCoordinator.start(id: id)
            }
        }.store(in: &cancellabes)
    }
}
