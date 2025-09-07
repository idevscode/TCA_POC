//
//  ContentView.swift
//  TCA_POC
//
//  Created by dilshad haidari on 31/08/25.
//

import SwiftUI
import ComposableArchitecture


struct ContentView: View {
    var body: some View {
        LoginView(store: Store(initialState: LoginReducer.State(), reducer: {LoginReducer()
        }
       )
      )
    }
}

#Preview {
    ContentView()
}
