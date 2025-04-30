//  ProductListService.swift
//  ProductList-ios
//
//  Created by Mahsun Abuzeyitoğlu on 28.04.2025.
//
// MARK: - For Combine

import Foundation
import Combine

protocol ProductListService {
    func getProductList() -> AnyPublisher<[ProductListModel]?,BaseError>
    func getHeaderProcuts(limit: Int) -> AnyPublisher<[ProductListModel]?,BaseError>
}

struct ProductListServiceImpl: ProductListService {
    private let provider = BaseMoyaProvider<ProductNetwork>()
}

extension ProductListServiceImpl {
    func getProductList() -> AnyPublisher<[ProductListModel]?,BaseError> {
        return Future { promise in
            provider.request(.getProdcuts) { result in
                switch result {
                case .success(let respose):
                    do {
                        let _response = try JSONDecoder().decode([ProductListModel].self, from: respose.data)
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
    
    func getHeaderProcuts(limit: Int) -> AnyPublisher<[ProductListModel]?,BaseError> {
        return Future { promise in
            provider.request(.getHeaderProcuts(limit: limit)) { result in
                switch result {
                case .success(let respose):
                    do {
                        let _response = try JSONDecoder().decode([ProductListModel].self, from: respose.data)
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
