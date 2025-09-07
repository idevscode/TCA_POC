//
//  File.swift
//  TCA_POC
//
//  Created by dilshad haidari on 06/09/25.
//

import Foundation



protocol NetworkProvider{
    func networkExecutor(request: RequestProtocol) async throws -> Data
}

class NetworkExecutor: NetworkProvider {
        public func networkExecutor(request: RequestProtocol) async throws -> Data{
            
            guard prepareRequest(request: request) != nil else {return Data()}
            
           let (data, response) = try await URLSession.shared.data(for: prepareRequest(request: request)!)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
            
            return data
        }
    
    
  func prepareRequest(request: RequestProtocol) -> URLRequest?{
      
        let base = request.baseUrl+request.path
        print("base: \(base)")
     
        guard var urlComponents = URLComponents(string: base) else {
                  print("Invalid base URL or path")
                  return nil
        }


        if request.method == .get, let parameters = request.parameters {
          urlComponents.queryItems = parameters.map {
              URLQueryItem(name: $0.key, value: "\($0.value)")
          }
        }

        guard let finalURL = urlComponents.url else {
          fatalError("Invalid URL") // or handle it gracefully
        }
        
        var urlRequest = URLRequest(url: finalURL)
        urlRequest.httpMethod = request.method.rawValue
        request.header.forEach { (key: String, value: String) in
          urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if request.method == .post, let parameters = request.parameters {
          urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }
        
        return urlRequest
  }
}


        


