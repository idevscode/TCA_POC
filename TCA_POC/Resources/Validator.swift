//
//  Validator.swift
//  TCA_POC
//
//  Created by dilshad haidari on 07/09/25.
//

import Foundation


struct Validator{
    
    
    static func isEmailValid(email: String) -> Bool {
                let pattern = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern)
                    .evaluate(with: email)
        
    }
}
