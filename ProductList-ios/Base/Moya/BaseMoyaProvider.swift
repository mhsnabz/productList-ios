//
//  BaseMoyaProvider.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import Moya
func JSONResponseDataFormatter(_ data: Data) -> String {

/*#warning("dont forget") // FIXME: - remove at relase
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
#if DEBUG
        return String(data: data, encoding: .utf8) ?? ""
#endif
        return ""
    }*/

    return ""
}
final class BaseMoyaProvider<Target: TargetType>: MoyaProvider<Target> {
    public init(
        endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
        requestClosure _: @escaping RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
        session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(endpointClosure: endpointClosure, requestClosure: { endpoint, closure in
            var request = try! endpoint.urlRequest() // Feel free to embed proper error handling
            
            // Set cache policy
            request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

            var curlCommand = "curl"

            // HTTP Method
            if let method = request.httpMethod {
                curlCommand += " -X \(method)"
            }

            // Headers
            if let headers = request.allHTTPHeaderFields {
                for (key, value) in headers {
                    curlCommand += " -H \"\(key): \(value)\""
                }
            }

            // Body (if any)
            if let body = request.httpBody,
               let bodyString = String(data: body, encoding: .utf8) {
                curlCommand += " --data '\(bodyString)'"
            }

            // URL
            if let url = request.url?.absoluteString {
                curlCommand += " \"\(url)\""
            }

            // Print the generated cURL command
            Logger.d(message:"Generated cURL Command:")
            Logger.d(message:curlCommand)

            closure(.success(request))
        },
        stubClosure: stubClosure,
        session: session,
        plugins: plugins,
        trackInflights: trackInflights)
    }
}
