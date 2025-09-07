//
//  RequestProtocol.swift
//  TCA_POC
//
//  Created by dilshad haidari on 06/09/25.
//

import Foundation

protocol RequestProtocol{
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String: Any]? {get}
    
}

extension RequestProtocol{
    
    var baseUrl: String {
        return Constants.baseUrl
    }
    
    var header: [String : String] {
      return [
        "Content-Type": "application/json",
              "x-api-key": "reqres-free-v1"]
    }
    
    var parameters: [String : Any]?{
        return nil
    }
    
    
}


enum HTTPMethod: String{
    case get  = "GET"
    case post = "POST"
}
