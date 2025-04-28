//
//  SceneDelegate.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let vc = ProductListBuilderImpl().build()
        let navigationController = UINavigationController(rootViewController: vc) // Navigation controller'a ekle
        window.rootViewController = navigationController // rootViewController olarak ayarla
        self.window = window
        window.makeKeyAndVisible()
    }
}

