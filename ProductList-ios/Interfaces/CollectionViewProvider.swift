//
//  CollectionViewProvider.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit

/// Protocol defining the necessary methods for a collection view provider.
/// This protocol is generic, allowing customization for different data types (`T`) and index path types (`I`).
protocol CollectionViewProvider {
    /// The type of data stored in the collection view.
    associatedtype T

    /// The type representing the index path, usually `IndexPath`.
    associatedtype I

    /// The list of data items to be displayed in the collection view.
    var dataList: [T] { get set }

    /// Configures the collection view, typically setting the data source and delegate.
    /// - Parameter collectionView: The collection view to configure.
    func setupCollectionView(collectionView: UICollectionView)

    /// Called when an item in the collection view is selected.
    /// - Parameter indexPath: The index path of the selected item.
    func didSelectItem(indexPath: I)

    /// Prepares the collection view with a new data set.
    /// - Parameter data: The data to be displayed in the collection view.
    func prepareCollectionView(data: [T])

    /// Reloads the data in the collection view. Useful for refreshing the content.
    func reloadCollectionView()
}

/// Extension to provide default implementations for optional methods in `CollectionViewProvider`.
extension CollectionViewProvider {
    /// Default implementation of `didSelectItem` that does nothing.
    /// Override this method to handle item selection.
    func didSelectItem(indexPath _: I) {}

    /// Default implementation of `reloadCollectionView` that does nothing.
    /// Override this method to refresh the collection view content.
    func reloadCollectionView() {}
}

