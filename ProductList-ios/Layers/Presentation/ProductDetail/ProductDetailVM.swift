//  ProductDetailVM.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  

import Foundation
import Combine

protocol ProductDetailVM: ViewModel {
    func activityHandler(input: AnyPublisher<ProductDetailVMImpl.ProductDetailVMInput, Never>) -> AnyPublisher<ProductDetailVMImpl.ProductDetailVMOutput, Never>
}

final class ProductDetailVMImpl: ProductDetailVM {
    // Combine operations
    private let output = PassthroughSubject<ProductDetailVMOutput, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var useCase: ProductDetailUseCaseImpl?
    private let productId: Int
    
    init(useCase: ProductDetailUseCaseImpl,productId: Int){
        self.useCase = useCase
        self.productId = productId
    }
    
    func activityHandler(input: AnyPublisher<ProductDetailVMInput, Never>) -> AnyPublisher<ProductDetailVMOutput, Never> {
        input.sink { [weak self] inputEvent in
            switch inputEvent {
            case .start:
                self?.start()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
}

// MARK: - Events
extension ProductDetailVMImpl {
    enum ProductDetailVMOutput {
        case isLoading(isShow: Bool)
        case error(error: BaseError)
        case prepareUI(model: ProductListModel?)
    }

    enum ProductDetailVMInput {
        case start
    }
}

// MARK: - Services
extension ProductDetailVMImpl {
    private func start() {
        self.output.send(.isLoading(isShow: true))
        self.useCase?.getProductDetail(productId: productId).sink(receiveCompletion: {[weak self] completion in
            guard let self else { return }
            switch completion {
            case .failure(let failure):
                Logger.d(message: "error :\(failure.localizedDescription)")
                self.output.send(.error(error: failure))
            default: break
            }
            self.output.send(.isLoading(isShow: false))
        }, receiveValue: {[weak self] model in
            guard let self else { return }
            self.output.send(.prepareUI(model: model))
        }).store(in: &cancellables)
    }
}
