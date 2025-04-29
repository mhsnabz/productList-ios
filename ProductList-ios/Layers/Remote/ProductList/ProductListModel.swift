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
    
    var sellerCount: Int = 0
    var discountRate: Int = 0
    var followerCount: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id, title, price, description, category, image, rating
    }
    
    mutating func setSellerCount(count: Int) {
        self.sellerCount = count
    }
    
    mutating func setFollowerCount(count: Int) {
        self.followerCount = count
    }
    
    mutating func setDiscountRate(rate: Int) {
        self.discountRate = rate
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}


