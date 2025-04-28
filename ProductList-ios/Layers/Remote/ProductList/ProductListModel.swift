//
//  ProductListModel.swift
//  ProductList-ios
//
//  Created by srbrt on 28.04.2025.
//

import Foundation

// MARK: - ProductListModelElement
struct ProductListModel: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: String?
    let image: String?
    let rating: Rating?
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}


