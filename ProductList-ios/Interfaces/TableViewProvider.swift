//
//  TableViewProvider.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation
import UIKit

/// Protocol defining the necessary methods for a table view provider.
/// This protocol is generic, allowing customization for different data types (`T`) and index path types (`I`).
protocol TableViewProvider {
    /// The type of data stored in the table view.
    associatedtype T

    /// The type representing the index path, usually `IndexPath`.
    associatedtype I

    /// The list of data items to be displayed in the table view.
    var dataList: [T] { get set }

    /// Configures the table view, typically setting the data source and delegate.
    /// - Parameter tableView: The table view to configure.
    func setupTableView(tableView: UITableView)

    /// Called when an item in the table view is selected.
    /// - Parameter indexPath: The index path of the selected item.
    func didSelectItem(indexPath: I)

    /// Prepares the table view with a new data set.
    /// - Parameter data: The data to be displayed in the table view.
    func prepareTableView(data: [T])

    /// Reloads the data in the table view. Useful for refreshing the content.
    func reloadTableView()
}

/// Extension to provide default implementations for optional methods in `TableViewProvider`.
extension TableViewProvider {
    /// Default implementation of `didSelectItem` that does nothing.
    /// Override this method to handle item selection.
    func didSelectItem(indexPath _: I) {}

    /// Default implementation of `reloadTableView` that does nothing.
    /// Override this method to refresh the table view content.
    func reloadTableView() {}

    /// Default implementation of `prepareTableView` that does nothing.
    /// Override this method to prepare the table view with data.
    func prepareTableView(data _: [T]) {}
}

