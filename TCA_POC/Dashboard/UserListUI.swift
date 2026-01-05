//
//  UserListUI.swift
//  TCA_POC
//
//  Created by Dilshad Haidari on 18/12/25.
//
import SwiftUI
import ComposableArchitecture


struct UserListUI: View {
    
    let store: StoreOf<DashboardReducer>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottom) {
                List {
                    ForEach(viewStore.userList, id: \.id) { product in
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                            
                            Text(product.description)
                                .font(.subheadline)
                        }
                        .onAppear {
                            // 🔥 Pagination trigger
                            if product.id == viewStore.userList.last?.id,
                               !viewStore.isLoading {
                                viewStore.send(
                                    .paginateTo(pageNo: viewStore.pageNo + 1)
                                )
                            }
                        }
                    }
                    
                    // 👇 Bottom loader
                    if viewStore.isLoading {
                        ProgressView()
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .padding(.bottom, 16)
                    }
                }
            }
            .listStyle(.plain)
            .task {
                viewStore.send(.loadUserList)
            }
        }
    }
}
