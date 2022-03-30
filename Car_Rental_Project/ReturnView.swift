//
//  ReturnView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI

struct ReturnView: View {
    @State var homeisActive = false
    
    var body: some View {
        
        if homeisActive {
            NavigationLink(destination: ContentView(),label: {
                Text("Menu główne").foregroundColor(.black)
                Image("main.icon").resizable().frame(width: 25 , height: 25)
                
            })}
        
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.red,Color.blue]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea(.all,edges: .all)
                Text("Zwrot Samochodu").fontWeight(.bold).font(.system(size: 25))
                    
            }.gesture(DragGesture(minimumDistance: 10, coordinateSpace: .global)
                .onEnded { value in
                    let horizontalAmount = value.translation.width as CGFloat
                    let verticalAmount = value.translation.height as CGFloat
                    
                    if abs(horizontalAmount) > abs(verticalAmount) {
//                        print(horizontalAmount > 0 ? "left swipe" : "right swipe")
                        
                        if(horizontalAmount>0){
                            homeisActive.toggle()
                        }
                    } else {
//                        print(verticalAmount < 0 ? "up swipe" : "down swipe")
                    }
                }).hiddenNavigationBarStyle()
        }
    
    }


struct ReturnView_Previews: PreviewProvider {
    static var previews: some View {
        ReturnView()
    }
}

