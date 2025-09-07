//
//  AuthRepository.swift
//  TCA_POC
//
//  Created by dilshad haidari on 07/09/25.
//

import Foundation
import Dependencies
protocol AuthRepository: AnyObject{
    
    func login(request: LoginRequest) async throws -> LoginResponse

}

class AuthDataProvider: AuthRepository {
    
    var networkCLient: NetworkProvider
    var jsonDecoder: JSONEncoderDecoder
    
    init(networkCLient: NetworkProvider, jsonDecoder: JSONEncoderDecoder) {
        self.networkCLient = NetworkExecutor()
        self.jsonDecoder = JsonSerializer()
        
    }
    
    func login(request: LoginRequest) async throws -> LoginResponse {
        let data: Data = try await self.networkCLient.networkExecutor(request: request)
        let response: LoginResponse = try self.jsonDecoder.serialize(data: data)
        return response
    }
}


extension AuthDataProvider: DependencyKey{
    static var liveValue: AuthDataProvider {
        AuthDataProvider(networkCLient: NetworkExecutor(), jsonDecoder: JsonSerializer())
    }
}

extension DependencyValues {
    
    var authDataProvider: AuthDataProvider{
        get { self[AuthDataProvider.self] }
        set { self[AuthDataProvider.self] = newValue }
    }
    
}
