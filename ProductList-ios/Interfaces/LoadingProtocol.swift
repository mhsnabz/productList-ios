//
//  LoadingProtocol.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit
public protocol LoadingProtocol {
    var animator: CustomProgress { get }
    func loading(isShow: Bool)
}

public extension LoadingProtocol where Self: UIViewController {
    
    func loading(isShow: Bool) {
        if isShow {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if let window = UIApplication.shared.getKeyWindow() {
                    self.animator.frame = window.bounds
                    window.addSubview(self.animator)
                    self.animator.loading(isShow: isShow)
                }
            }
        }else {
            DispatchQueue.main.async { [weak self] in
                self?.animator.loading(isShow: isShow)
                self?.animator.removeFromSuperview()
            }
        }
    }
}

