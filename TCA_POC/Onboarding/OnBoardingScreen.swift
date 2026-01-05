//
//  OnBoardingScreen.swift
//  TCA_POC
//
//  Created by dilshad haidari on 08/09/25.
//

import SwiftUI

struct OnBoardingScreen: View {
    
    @State private var page = 0
    private let images = ["image_1", "image_2", "image_3"] // add these to Assets

    var body: some View {
        VStack{
            TabView(selection: $page){
                ForEach(images.indices, id:\.self){ i in
                    Image(images[i])
                        .resizable()
                        .scaledToFit()
                        .tag(i)
                        .padding(.horizontal, 20)

                }
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .padding()
            
            HStack{
                Button("Skip") {
                    page = images.count - 1
                }
                .padding()
                Spacer()
                Button(page == images.count - 1 ? "Done" : "Next") {
                    withAnimation { page = min(page + 1, images.count - 1)
                    }
                }
                .padding(.horizontal, 24)
            }
        }.animation(.easeInOut, value: page)
        
    }
}

#Preview {
    OnBoardingScreen()
}
