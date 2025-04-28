//  ProductListVM.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  

import Foundation
import Combine

protocol ProductListVM: ViewModel {
    func activityHandler(input: AnyPublisher<ProductListVMImpl.ProductListVMInput, Never>) -> AnyPublisher<ProductListVMImpl.ProductListVMOutput, Never>
}

final class ProductListVMImpl:  ProductListVM  {
    // Combine operations
    private let output = PassthroughSubject<ProductListVMOutput, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private var useCase: ProductListUseCase?
    private var sections: [SectionType] = []
    //private var dataList: [<#DataModel#>] = []
    
    init(useCase: ProductListUseCase){
        self.useCase = useCase
    }
    
    func activityHandler(input: AnyPublisher<ProductListVMInput, Never>) -> AnyPublisher<ProductListVMOutput, Never> {
        input.sink { [weak self] inputEvent in
            switch inputEvent {
            default: break
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
}

// MARK: - Events
extension ProductListVMImpl {
    enum ProductListVMOutput {
        case isLoading(isShow: Bool), updateUI(sections: [SectionType])
    }

    enum ProductListVMInput {
        case start
    }

    enum SectionType {
        case defaultSection(rows: [RowType])
    }
    
    enum RowType {
        case item
    }
}

// MARK: - Prepare UI
extension ProductListVMImpl {
}

// MARK: - Services
extension ProductListVMImpl {
    
}
