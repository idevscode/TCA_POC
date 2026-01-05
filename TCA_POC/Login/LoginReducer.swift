//
//  LoginState.swift
//  TCA_POC
//
//  Created by dilshad haidari on 31/08/25.
//

import Foundation
import ComposableArchitecture
import SwiftUI




import ComposableArchitecture

struct LoginReducer: Reducer {
    
    @Dependency(\.authDataProvider) var authDataProvider
    
    struct State: Equatable {
        var email: String = ""
        var password: String = ""
        var isLoading: Bool = false
        var errorMessage: String? = nil
        
        var isEmailValid: Bool {
            Validator.isEmailValid(email: email)
        }
        
        var isPasswordValid: Bool {
            password.count >= 6
        }
        
        var emailValidationMessage : String? {
            isEmailValid || email.isEmpty ? nil : "Invalid Email"
        }
        
        var passwordValidationMessage : String? {
            isPasswordValid || password.isEmpty ? nil : "Invalid Password"
        }
        
        var isValid: Bool {
           isEmailValid && isPasswordValid
        }
    }
    
    enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
        case loginButtonTapped
        case loginResponse(Result<LoginResponse, LoginError>)
    }
    
    
    
    enum LoginError: Error, Equatable {
        case invalidCredentials
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .emailChanged(email):
            state.email = email
            return .none
            
        case let .passwordChanged(password):
            state.password = password
            return .none
            
        case .loginButtonTapped:
            state.isLoading = true
            state.errorMessage = nil
            let email = state.email
            let password = state.password
            
            return .run { send in
                do {
                    let loginRequest = LoginRequest(email: email, password: password)
                    let success = try await authDataProvider.login(request: loginRequest)
                    await send(.loginResponse(.success(success)))
                } catch {
                    await send(.loginResponse(.failure(.invalidCredentials)))
                }
            }
            
        case let .loginResponse(.success(success)):
            state.isLoading = false
            if !success.token.isEmpty {
                state.errorMessage = ""
            }
            return .none
            
        case .loginResponse(.failure):
            state.isLoading = false
            state.errorMessage = "Login attempt failed"
            return .none
        }
    }
}


