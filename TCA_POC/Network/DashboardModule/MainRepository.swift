//
//  MainRepository.swift
//  TCA_POC
//
//  Created by Dilshad Haidari on 18/12/25.
//

import Foundation
import Dependencies

protocol MainRepository : Sendable {
    func getUserList(userRequest: ProductRequest) async throws -> ProductsResponse
    
}


actor MainRepositoryProvider: MainRepository {
    
    let networkClient: NetworkProvider
    let jsonDecoder: JSONEncoderDecoder
    
    init(networkClient: NetworkProvider, jsonDecoder: JSONEncoderDecoder) {
        self.networkClient = networkClient
        self.jsonDecoder = jsonDecoder
    }
    
    func getUserList(userRequest: ProductRequest) async throws -> ProductsResponse {
        let data = try await self.networkClient.networkExecutor(request: userRequest)
        let response = try jsonDecoder.serialize(data: data) as ProductsResponse
        return response
    }
}

extension MainRepositoryProvider: DependencyKey{
    static var liveValue: MainRepositoryProvider {
        MainRepositoryProvider(networkClient: NetworkExecutor(), jsonDecoder: JsonSerializer())
    }
}

extension DependencyValues {
    
    var mainDataProvider: MainRepositoryProvider{
        get { self[MainRepositoryProvider.self] }
        set { self[MainRepositoryProvider.self] = newValue }
    }
}



