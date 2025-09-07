//
//  JsonSerializer.swift
//  TCA_POC
//
//  Created by dilshad haidari on 07/09/25.
//

import Foundation

public struct BaseResponse<T: Codable> : Codable {
    var result: T?
}

protocol JSONEncoderDecoder{
    
    func serialize<T: Codable>(data: Data) throws -> T where T : Decodable, T : Encodable
    
}

class JsonSerializer: JSONEncoderDecoder{
    let decoder = JSONDecoder()
    
    func serialize<T>(data: Data) throws -> T where T : Decodable, T : Encodable {
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print("json received: \(json)")
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        }
    }
    
    
    
}
