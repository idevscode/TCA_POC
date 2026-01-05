//
//  DashboardView.swift
//  TCA_POC
//
//  Created by dilshad haidari on 08/09/25.
//

import SwiftUI

struct DashboardView: View {
    @State var radioArr: [RadioModel] = [RadioModel(title: "25", isSelected: false), RadioModel(title: "26", isSelected: false), RadioModel(title: "27", isSelected: false), RadioModel(title: "28")]
    var body: some View {
        VStack(alignment: .leading){
             Image("product_1")
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
                    .frame(height: 250)
                    .clipped()
                
            VStack{
                HStack{
                    Text("Nike Air Max 2022")
                        .font(.largeTitle)
                    Spacer()
                    Image("favourite")
                        .background(.black)
                }
                
                HStack{
                    Text("423 SOLD")
                        .frame(width: 120, height: 40)
                        .background(.gray)
                        .foregroundStyle(.black)

                    Image(systemName:"star.fill")
                    Text("4.3")
                    Spacer()
                    Text("53 reviews")
                        
                }
                
                Divider()
                    .overlay(.gray)
                    
                
                VStack(alignment: .leading){
                    Text("Description")
                        .font(.title)
                    
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.")
                        .font(.system(size: 15))
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    Text("Size")
                    
                    HStack{
                        ForEach (0..<radioArr.count, id:\.self){ index in
                            Text(radioArr[index].title)
                                    .font(.title)
                                    .foregroundStyle(radioArr[index].isSelected ? .white : .black)
                                    .circleButton(size: 50, color: radioArr[index].isSelected ? .black : .clear) {
                                        for i in radioArr.indices {
                                                                    radioArr[i].isSelected = (i == index)
                                                                }
                                    }
                        
                        }
                    }

                        
                    
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                

            }
            
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .border(Color.red)
        .ignoresSafeArea()
        
        
    }
    
    
    func sizeButtonComponent() -> some View {
        return Button {
            
        } label: {
            Circle()
                .stroke(.gray,lineWidth: 2)
                .frame(width: 50, height: 50)
            
        }
    }
}

#Preview {
    DashboardView()
}











//                AsyncImage(url: URL(string: "\(Constants.dummyJson)/product-images/beauty/essence-mascara-lash-princess/1.webp")) { image in
//
//                        image
//                            .resizable()
//                            .scaledToFit()
//                    } placeholder: {
//
//                        ProgressView()
//                    }

struct RadioModel{
    let title: String
    var isSelected: Bool = false
}
