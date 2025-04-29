//  ProductDetailService.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 29.04.2025.
//  
// MARK: - For Combine

import Foundation
import Combine

protocol ProductDetailService {
    func getProductDetail(productId: Int) -> AnyPublisher<ProductListModel?,BaseError>
}

struct ProductDetailServiceImpl: ProductDetailService {
    private let provider = BaseMoyaProvider<ProductNetwork>()
}

extension ProductDetailServiceImpl {
    func getProductDetail(productId: Int) -> AnyPublisher<ProductListModel?,BaseError> {
        return Future { promise in
            provider.request(.getProductDetail(productId: productId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let _response = try JSONDecoder().decode(ProductListModel.self, from: response.data)
                        promise(.success(_response))
                    } catch {
                        promise(.failure(BaseError.decodingError))
                    }
                case .failure(let error):
                    switch error {
                    case .underlying(let error, _):
                        promise(.failure(BaseError.defaultMessageErrorType(description: error.localizedDescription)))
                    default:
                        promise(.failure(BaseError.serverError(error.localizedDescription)))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
