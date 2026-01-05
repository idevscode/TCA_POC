//
//  CircleButtonModifier.swift
//  TCA_POC
//
//  Created by dilshad haidari on 11/09/25.
//

import SwiftUI

struct CircleButtonModifier: ViewModifier {
    let backGroundColor: Color
    let action: ()->Void
    let size: CGFloat
    
    init(backGroundColor: Color, action: @escaping () -> Void, size: CGFloat = 50) {
        self.backGroundColor = backGroundColor
        self.action = action
        self.size = size
    }
    
    func body(content: Content)-> some View {
        Button(action: action) {
            ZStack{
                if backGroundColor == .clear {
                    Circle()
                        .stroke(.gray, lineWidth: 2)
                        .frame(width: size, height: size)
                }
                Circle()
                    .fill(backGroundColor)
                    .frame(width: size, height: size)
                    
                content
            }
        }
        .buttonStyle(.plain)
            
    }
}

extension View {
    func circleButton(size: CGFloat, color:Color, action: @escaping () -> Void) -> some View{
        self.modifier(CircleButtonModifier(backGroundColor: color, action: action, size: size))
    }
}


#Preview {
    
}
