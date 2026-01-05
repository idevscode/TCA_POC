//
//  File.swift
//  TCA_POC
//
//  Created by dilshad haidari on 06/09/25.
//

import Foundation



protocol NetworkProvider: Sendable{
    func networkExecutor(request: RequestProtocol) async throws -> Data
}

enum NetworkError: Error, LocalizedError {
    case invalidRequest
    case invalidResponse
    case httpError(statusCode: Int, data: Data)
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidRequest:
            return "Invalid request configuration"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode, _):
            return "HTTP Error: \(statusCode)"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}

final class NetworkExecutor: NetworkProvider, Sendable {
    
    public func networkExecutor(request: RequestProtocol) async throws -> Data {
            
            guard let urlRequest = prepareRequest(request: request) else {
                print("❌ Failed to prepare request")
                throw NetworkError.invalidRequest
            }
            
            // Print full request details
            printRequestDetails(urlRequest)
            
            do {
                let (data, response) = try await URLSession.shared.data(for: urlRequest)
                
                // Print response details
                printResponseDetails(response: response, data: data)
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                // Check status code
                guard (200...299).contains(httpResponse.statusCode) else {
                    print("❌ HTTP Error: \(httpResponse.statusCode)")
                    
                    // Try to parse error response
                    if let errorString = String(data: data, encoding: .utf8) {
                        print("❌ Error Response Body: \(errorString)")
                    }
                    
                    throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
                }
                
                print("✅ Request successful!")
                return data
                
            } catch let error as NetworkError {
                throw error
            } catch {
                print("❌ URLSession Error: \(error)")
                print("❌ Error Details: \(error.localizedDescription)")
                if let urlError = error as? URLError {
                    print("❌ URLError Code: \(urlError.code.rawValue)")
                    print("❌ URLError Description: \(urlError.localizedDescription)")
                }
                throw error
            }
        }
    
    private func printResponseDetails(response: URLResponse, data: Data) {
           print("\n" + String(repeating: "=", count: 60))
           print("📥 RECEIVED RESPONSE")
           print(String(repeating: "=", count: 60))
           
           if let httpResponse = response as? HTTPURLResponse {
               print("📥 Status Code: \(httpResponse.statusCode)")
               print("📥 Headers:")
               httpResponse.allHeaderFields.forEach { key, value in
                   print("   \(key): \(value)")
               }
           }
           
           print("📥 Data Size: \(data.count) bytes")
           
           if let jsonString = String(data: data, encoding: .utf8) {
               print("📥 Response Body:")
               print(jsonString)
           } else {
               print("📥 Response Body: (binary data)")
           }
           
           print(String(repeating: "=", count: 60) + "\n")
       }
   }

    
    func prepareRequest(request: RequestProtocol) -> URLRequest? {
            let base = request.baseUrl + request.path
            
            print("\n" + String(repeating: "=", count: 60))
            print("🔵 PREPARING REQUEST")
            print(String(repeating: "=", count: 60))
            print("🔵 Base URL: \(request.baseUrl)")
            print("🔵 Path: \(request.path)")
            print("🔵 Full Base: \(base)")
            print("🔵 Method: \(request.method.rawValue)")
            print("🔵 Parameters: \(request.parameters ?? [:])")
            print("🔵 Headers: \(request.header)")
            
            guard var urlComponents = URLComponents(string: base) else {
                print("❌ Invalid base URL or path")
                return nil
            }
            
            // Add query parameters for GET requests
            if request.method == .get, let parameters = request.parameters {
                urlComponents.queryItems = parameters.map {
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                }
                print("🔵 Query Items: \(urlComponents.queryItems ?? [])")
            }
            
            guard let finalURL = urlComponents.url else {
                print("❌ Failed to create final URL from components")
                return nil
            }
            
            print("🔵 Final URL: \(finalURL.absoluteString)")
            
            var urlRequest = URLRequest(url: finalURL)
            urlRequest.httpMethod = request.method.rawValue
            
            // Add headers
            request.header.forEach { (key: String, value: String) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            
            // Add body for POST requests
            if request.method == .post, let parameters = request.parameters {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                    if let bodyString = String(data: urlRequest.httpBody!, encoding: .utf8) {
                        print("🔵 Request Body: \(bodyString)")
                    }
                } catch {
                    print("❌ Failed to serialize parameters: \(error)")
                }
            }
            
            print(String(repeating: "=", count: 60) + "\n")
            
            return urlRequest
        }
    
    private func printRequestDetails(_ request: URLRequest) {
            print("\n" + String(repeating: "=", count: 60))
            print("📤 SENDING REQUEST")
            print(String(repeating: "=", count: 60))
            print("📤 URL: \(request.url?.absoluteString ?? "nil")")
            print("📤 Method: \(request.httpMethod ?? "nil")")
            print("📤 Headers:")
            request.allHTTPHeaderFields?.forEach { key, value in
                print("   \(key): \(value)")
            }
            if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
                print("📤 Body: \(bodyString)")
            }
            print(String(repeating: "=", count: 60) + "\n")
        }



        


