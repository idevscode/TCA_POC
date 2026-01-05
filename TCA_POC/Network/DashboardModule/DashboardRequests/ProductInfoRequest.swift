//
//  ProductInfo.swift
//  TCA_POC
//
//  Created by dilshad haidari on 10/09/25.
//

import Foundation


class ProductRequest : RequestProtocol{
    
    
    let productId: String
    
    
    var baseUrl: String {
        Constants.baseUrl
    }
    
    var path: String {
        "/api/login"
    }
    
    var headers: [String : String] {
        [
            "x-api-key": "reqres-free-v1",
            "Content-Type": "application/json",
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var method: HTTPMethod {
        HTTPMethod.post
    }
    
    var parameters: [String : Any]?{
        [
            "email": email,
            "password": password
        ]
    }
    
}
