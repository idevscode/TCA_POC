//
//  UserListResponse.swift
//  TCA_POC
//
//  Created by Dilshad Haidari on 18/12/25.
//

import Foundation

import Foundation

// MARK: - Root Response
struct ProductsResponse: Codable, Equatable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - Product
struct Product: Codable, Equatable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
   
}

