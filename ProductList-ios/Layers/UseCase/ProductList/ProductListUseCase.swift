//  ProductListUseCase.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  

import Foundation
import Combine

protocol ProductListUseCase {
    func getProductList() -> AnyPublisher<[ProductListModel]?,BaseError>
    func getHeaderProcuts(limit: Int) -> AnyPublisher<[ProductListModel]?,BaseError>
}

struct ProductListUseCaseImpl: ProductListUseCase {
    private let service: ProductListServiceImpl
    init(service: ProductListServiceImpl){
        self.service = service
    }
}

// MARK: - For Combine
extension ProductListUseCaseImpl {
    func getProductList() -> AnyPublisher<[ProductListModel]?,BaseError> {
        service.getProductList()
    }
    
    func getHeaderProcuts(limit: Int) -> AnyPublisher<[ProductListModel]?,BaseError> {
        service.getHeaderProcuts(limit: limit)
    }
}
