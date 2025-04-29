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
   
    
    init(useCase: ProductDetailUseCaseImpl){
        self.useCase = useCase
    }
    
    func activityHandler(input: AnyPublisher<ProductDetailVMInput, Never>) -> AnyPublisher<ProductDetailVMOutput, Never> {
        input.sink { [weak self] inputEvent in
            switch inputEvent {
            default: break
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
}

// MARK: - Events
extension ProductDetailVMImpl {
    enum ProductDetailVMOutput {
        case isLoading(isShow: Bool)
    }

    enum ProductDetailVMInput {
        case start
    }
}

// MARK: - Prepare UI
extension ProductDetailVMImpl {
    private func prepareUI() {
        
    }
}

// MARK: - Services
extension ProductDetailVMImpl {
    
}
