//  ProductDetailUseCase.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  

import Foundation
import Combine

protocol ProductDetailUseCase {
   
}

struct ProductDetailUseCaseImpl: ProductDetailUseCase {
    private let service: ProductDetailServiceImpl
    init(service: ProductDetailServiceImpl){
        self.service = service
    }
}

// MARK: - For Combine
extension ProductDetailUseCaseImpl {
    
}
