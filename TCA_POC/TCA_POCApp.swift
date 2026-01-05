//
//  TCA_POCApp.swift
//  TCA_POC
//
//  Created by dilshad haidari on 31/08/25.
//

import SwiftUI
import ComposableArchitecture


enum AppStorageKeys {
    static let isLoggedIn = "isLoggedIn"
}

@main
struct TCA_POCApp: App {
    @AppStorage(AppStorageKeys.isLoggedIn) private var isLoggedIn = false
    
    
    
    var body: some Scene {
        WindowGroup {
//            DashboardView()
            
            
            NavigationStack{
                if (isLoggedIn == true) {
                    UserListUI(
                        store: Store(
                            initialState: DashboardReducer.State(),
                            reducer: {
                                DashboardReducer()
                            }
                        )
                    )
                } else {
                    LoginView(
                        store: Store(
                            initialState: LoginReducer.State(),
                            reducer: {LoginReducer()}
                        )
                    )
                }
                
            }
        }
    }
}
