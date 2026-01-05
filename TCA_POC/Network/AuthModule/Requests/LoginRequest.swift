//
//  LoginRequest.swift
//  TCA_POC
//
//  Created by dilshad haidari on 07/09/25.
//

import Foundation

final class LoginRequest : RequestProtocol{
    
    
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    var baseUrl: String {
        Constants.baseUrl
    }
    
    var path: String {
        "/api/login"
    }
    
    var header: [String : String] {
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
