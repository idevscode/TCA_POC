//
//  DashboardReducer.swift
//  TCA_POC
//
//  Created by dilshad haidari on 10/09/25.
//

import Foundation
import ComposableArchitecture


 struct DashboardReducer: Reducer {
    
    @Dependency(\.mainDataProvider) var repositoryProvider
    
    
    struct State: Equatable {
        var userList: [Product] = []
        var isLoading: Bool = false
        var errorMessage: String? = nil
        var pageNo: Int = 1
    }
    
    enum Action: Equatable {
        case loadUserList
        case loadResponse(Result<ProductsResponse, ErrorInfo>)
        case paginateTo(pageNo: Int)
        case dismissError
    }
    
    struct ErrorInfo: Error, Equatable {
        let message: String
        let technicalDetails: String
        
        static func from(_ error: Error) -> ErrorInfo {
            let message: String
            let details: String
            
            if let urlError = error as? URLError {
                message = "Network Error"
                details = """
                Code: \(urlError.code.rawValue)
                Description: \(urlError.localizedDescription)
                """
            } else if let networkError = error as? NetworkError {
                message = networkError.errorDescription ?? "Network Error"
                details = "\(networkError)"
            } else {
                message = "Unknown Error"
                details = error.localizedDescription
            }
            
            return ErrorInfo(message: message, technicalDetails: details)
        }
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .loadUserList:
                guard !state.isLoading else { return .none }
                state.isLoading = true
                state.errorMessage = nil
                
                print("\n🎬 Action: loadUserList triggered")
                print("📄 Current page: \(state.pageNo)")
                
                return .run { [pageNo = state.pageNo] send in
                    do {
                        try await Task.sleep(nanoseconds: 300_000_000)
                        let response = try await repositoryProvider.getUserList(
                            userRequest: ProductRequest(pageNo: "\(pageNo)")
                        )
                        await send(.loadResponse(.success(response)))
                    } catch {
                        print("❌ Error in reducer: \(error)")
                        await send(.loadResponse(.failure(ErrorInfo.from(error))))
                    }
                }
                
            case let .loadResponse(.success(response)):
                state.isLoading = false
                state.userList.append(contentsOf: response.products)
                print("✅ Successfully loaded \(response.products.count) users")
                return .none
                
            case let .loadResponse(.failure(errorInfo)):
                state.isLoading = false
                state.errorMessage = """
                \(errorInfo.message)
                
                Technical Details:
                \(errorInfo.technicalDetails)
                """
                print("❌ Load failed: \(errorInfo.message)")
                print("❌ Details: \(errorInfo.technicalDetails)")
                return .none
                
            case let .paginateTo(pageNo):
                state.pageNo = pageNo
                return .send(.loadUserList)
                
            case .dismissError:
                state.errorMessage = nil
                return .none
            }
        }
    }


@MainActor
class ListViewModel: ObservableObject{
    
    
//    let networkClient: NetworkProvider
//    let jsonDecoder: JsonSerializer
    let repository: MainRepositoryProvider
    @Published var pageNo = 1
    @Published var userList : [Product] = []
    @Published var errorMessage : String?
    @Published var isLoading = false
    init( repository: MainRepositoryProvider) {
//        self.networkClient = networkClient
//        self.jsonDecoder = jsonDecoder
        self.repository = repository
    }
    
    func getUserList() async throws{
        do{
            isLoading = true
            defer {
                isLoading = false
            }
            let respone = try await self.repository.getUserList(userRequest: ProductRequest(pageNo: "\(pageNo)"))
            userList = respone.products
            print("111111111111111")
        } catch{
            print("test")
        }
    }
    
    
    
}
