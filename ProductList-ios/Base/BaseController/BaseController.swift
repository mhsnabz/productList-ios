//
//  BaseController.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import UIKit
import Combine
class BaseController: UIViewController,LoadingProtocol {
    var cancellabes = Set<AnyCancellable>()
    lazy var animator = CustomProgress()
    
    override func viewDidLoad() {
    }
    
    func showSimpleAlert(title: String, message: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: {[weak self] _ in
            self?.alertActionOK()
        })
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }

    func alertActionOK() {  }
}

enum BaseError: Error, LocalizedError {
    case networkError
    case serverError(String)
    case decodingError
    case defaultMessageErrorType(description: String)
    case custom(String)
    var errorDescription: String? {
        switch self {
        case .networkError: return "İnternet bağlantınızı kontrol edin."
        case .serverError(let msg): return "Sunucu hatası: \(msg)"
        case .decodingError: return "Veri işlenirken bir sorun oluştu."
        case .defaultMessageErrorType(let description): return description
        case .custom(let msg): return msg
        }
    }
}
