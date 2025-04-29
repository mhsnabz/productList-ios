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
            case .start:
                self?.start()
            }
        }.store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    private func start() {
        guard let useCase else { return }
        self.output.send(.isLoading(isShow: true))
        let productListPublisher = useCase.getProductList()
        let headerListPublisher = useCase.getHeaderProcuts(limit: 5)
        
        Publishers.Zip(productListPublisher, headerListPublisher)
            .sink {[weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.output.send(.isLoading(isShow: false))
                case .failure(let error):
                    self.output.send(.error(error: error))
                }
            } receiveValue: {[weak self] (productList, headerList) in
                guard let self else { return }
                let sections = self.prepareUI(headerList: headerList, productList: productList)
                self.output.send(.updateUI(sections: sections))
            }.store(in: &cancellables)

    }
}

// MARK: - Events
extension ProductListVMImpl {
    enum ProductListVMOutput {
        case isLoading(isShow: Bool), updateUI(sections: [SectionType])
        case error(error: BaseError)
    }

    enum ProductListVMInput {
        case start
    }

    enum SectionType {
        case listSection(rows: [RowType])
    }
    
    enum RowType {
        case headerProduct(model: [ProductListModel])
        case product(model: ProductListModel)
    }
}

// MARK: - Prepare UI
extension ProductListVMImpl {
    private func prepareUI(headerList: [ProductListModel]?, productList: [ProductListModel]?) -> [SectionType]{
        var headerRows = [RowType]()
        var rows = [RowType]()
        var headerModel = [ProductListModel]()
        
        if let headerList {
            headerList.forEach { model in
                var mutableModel = model
                mutableModel.setSellerCount(count: Int.random(in: 100...500))
                mutableModel.setFollowerCount(count: Int.random(in: 1000...10000))
                mutableModel.setDiscountRate(rate: Int.random(in: 10...50))
                headerModel.append(mutableModel)
            }
            headerRows.append(.headerProduct(model: headerModel))
        }
        
        self.sections.append(.listSection(rows: headerRows))

        if let productList {
            productList.forEach { model in
                var mutableModel = model
                mutableModel.setSellerCount(count: Int.random(in: 100...500))
                mutableModel.setFollowerCount(count: Int.random(in: 1000...10000))
                mutableModel.setDiscountRate(rate: Int.random(in: 10...50))
                rows.append(.product(model: mutableModel))
            }
        }
        
        self.sections.append(.listSection(rows: rows))

        
        return sections
    }
}

// MARK: - Services
extension ProductListVMImpl {
    
}
