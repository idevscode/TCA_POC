//
//  AppTextField.swift
//  TCA_POC
//
//  Created by dilshad haidari on 07/09/25.
//
import SwiftUI

struct AppTextField: View{
    
    let title: String
    @Binding var text: String
    let isValid: Bool
    let errorMsg: String?
    let keyBoard: UIKeyboardType
    let isSecure: Bool
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            if isSecure {
                SecureField(title, text: $text)
                                .padding(.leading, 12)
                                    .frame(maxWidth: .infinity, minHeight: 44)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .stroke(isValid || text.isEmpty ? Color.gray : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                
            }
            else {
                TextField(title, text: $text)
                                .padding(.leading, 12)
                                    .frame(maxWidth: .infinity, minHeight: 44)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .stroke(isValid || text.isEmpty ? Color.gray : Color.red, lineWidth: 1))
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                
            }
            Text(errorMsg ?? "")
                .font(.caption)
                .foregroundStyle(.red)
        }
        
    }
}

