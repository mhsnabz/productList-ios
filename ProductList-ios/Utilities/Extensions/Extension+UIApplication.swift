//
//  Extension+UIApplication.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit

extension UIApplication {
    func getKeyWindow() -> UIWindow? {
        // Find the first UIWindowScene from connected scenes
        if let windowScene = connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
            // Return the key window of the scene
            return windowScene.windows.first(where: { $0.isKeyWindow })
        }
        return nil
    }
}
