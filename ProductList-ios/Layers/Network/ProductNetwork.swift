//
//  ProductNetwork.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import Moya

enum ProductNetwork {
    case getProdcuts
    case getHeaderProcuts(limit: Int)
}

extension ProductNetwork: TargetType {
    var baseURL: URL { URL(string: ApiConstant.baseUrl)! }
    
    var path: String {
        switch self {
        case .getProdcuts:
            return ApiConstant.path
        case .getHeaderProcuts:
            return ApiConstant.path
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Moya.Task {
        switch self {
        case .getProdcuts:
            return .requestPlain
        case .getHeaderProcuts(let limit):
            var params = [String: Any]()
            params["limit"] = limit
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? { nil }
}
