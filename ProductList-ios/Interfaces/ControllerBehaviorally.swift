//
//  ControllerBehaviorally.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import SwiftUI
import UIKit
/// `ControllerCombineBehaviorally` is a protocol designed to define behaviors for controllers in UIKit-based projects using Combine.
/// It provides a flexible way to inject dependencies, set up bindings, and configure a component.
/// - Parameters:
///   - `P`: The provider type, representing a data or service provider used by the controller.
///   - `V`: The view model type that manages the data and logic.
///   - `C`: The component type, representing a UI component (e.g., a view or control) to configure.
protocol ControllerCombineBehaviorally {
    associatedtype P
    associatedtype V
    associatedtype C

    /// Injects the view model and provider into the controller.
    /// - Parameters:
    ///   - vm: The view model instance to inject.
    ///   - provider: The provider instance to inject.
    func inject(vm: V, provider: P)

    /// Sets up Combine bindings between the view model and the view.
    func binding()

    /// Configures the specified UI component.
    /// - Parameter component: The UI component to set up.
    func setupComponent(component: C)
}

/// Default implementation of `ControllerCombineBehaviorally` methods.
/// Provides empty implementations for `binding` and `setupComponent` to make them optional.
extension ControllerCombineBehaviorally {
    func binding() {}
    func setupComponent(component _: C) {}
}

/// `ControllerCombineBehaviorallyWithoutComponent` is a protocol for controllers using Combine but without a UI component to set up.
/// It defines basic dependency injection and binding setup functionality for view models.
/// - Parameters:
///   - `V`: The view model type.
protocol ControllerCombineBehaviorallyWithoutComponent {
    associatedtype V

    /// Injects the view model into the controller.
    /// - Parameter vm: The view model instance to inject.
    func inject(vm: V)

    /// Sets up Combine bindings between the view model and the view.
    func binding()
}

/// Default implementation of `ControllerCombineBehaviorallyWithoutComponent` methods.
/// Provides an empty implementation of `binding` to make it optional.
extension ControllerCombineBehaviorallyWithoutComponent {
    func binding() {}
}

/// `ControllerBehaviorallyForSwiftUI` is a protocol designed to integrate with SwiftUI views within UIKit controllers.
/// It facilitates the injection of a view model and SwiftUI view into the controller.
/// - Parameters:
///   - `V`: The view model type.
protocol ControllerBehaviorallyForSwiftUI {
    associatedtype V

    /// Injects the view model and SwiftUI view into the controller.
    /// - Parameters:
    ///   - vm: The view model instance to inject.
    ///   - view: The SwiftUI view instance to inject.
    func inject(vm: V, view: any View)
}

