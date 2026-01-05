//
//  MainRepository.swift
//  TCA_POC
//
//  Created by Dilshad Haidari on 18/12/25.
//

import Foundation
import Dependencies

protocol MainRepository : AnyObject {
    func getUserList(userRequest: ProductRequest) async throws -> [UserResponse]
}


actor MainRepositoryImpl: MainRepository {
    func getUserList(userRequest: ProductRequest) async throws -> [UserResponse] {
        
    }
}
