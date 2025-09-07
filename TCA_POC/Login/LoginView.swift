//
//  LoginView.swift
//  TCA_POC
//
//  Created by dilshad haidari on 31/08/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginReducer>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                
                
                AppTextField(
                    title: "Email",
                    text: viewStore.binding(
                        get: \.email,
                        send: LoginReducer.Action.emailChanged
                    ),
                isValid: viewStore.isEmailValid,
                    errorMsg: viewStore.emailValidationMessage,
                    keyBoard: .emailAddress,
                    isSecure: false
                )
                
                    
                Spacer().frame(height: 20)
                AppTextField(
                    title: "Password",
                    text: viewStore.binding(
                        get: \.password,
                        send: LoginReducer.Action.passwordChanged
                    ),
                isValid: viewStore.isPasswordValid,
                    errorMsg: viewStore.passwordValidationMessage,
                    keyBoard: .default,
                    isSecure: true
                )
                Spacer().frame(height: 20)
                Button {
                    viewStore.send(.loginButtonTapped)
                } label: {
                    if viewStore.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!viewStore.isValid || viewStore.isLoading)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: 200)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
        }
    }
}

