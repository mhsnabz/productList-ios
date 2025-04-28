//  ProductListUseCase.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//  

import Foundation
import Combine

protocol ProductListUseCase {
}

struct ProductListUseCaseImpl: ProductListUseCase {
    private let service: ProductListServiceImpl
    init(service: ProductListServiceImpl){
        self.service = service
    }
}

// MARK: - For Combine
extension ProductListUseCaseImpl {
}
