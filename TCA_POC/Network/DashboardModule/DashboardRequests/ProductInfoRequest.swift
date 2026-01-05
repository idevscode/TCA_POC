//
//  ProductInfo.swift
//  TCA_POC
//
//  Created by dilshad haidari on 10/09/25.
//

import Foundation


final class ProductRequest : RequestProtocol{
    
    let pageNo: String
    
    init(pageNo: String) {
        self.pageNo = pageNo
    }
    
    
    var baseUrl: String {
        Constants.dummyJson
    }
    
    var path: String {
        "/products"
    }
    
    var header: [String : String] {
        [
//                    "User-Agent": "MyApp/1.0 (iOS)",  // ✅ Add this
                    "Accept": "application/json",      // ✅ Add this
        ]
    }
    
    var parameters: [String : Any]? {
        ["limit": "10", "skip": pageNo]
        
    }
    
    var queryItems: [URLQueryItem]? {
        nil
//        [URLQueryItem(name: "page", value: String(pageNo))]
    }
    
    var method: HTTPMethod {
        HTTPMethod.get
    }
    
    
}
