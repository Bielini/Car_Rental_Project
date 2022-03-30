//
//  RentView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI

struct RentView: View {
    @State var homeisActive = false
    

    var body: some View {
        if homeisActive {
            NavigationLink(destination: ContentView(),label: {
                Text("Menu główne").foregroundColor(.black)
                Image("main.icon").resizable().frame(width: 25 , height: 25)
                
            })
              
            
            }
        
            VStack{
                LinearGradient(gradient: Gradient(colors: [Color.white,Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .ignoresSafeArea(.all,edges: .all).frame(height: 80)
                Text("Wypożycz Samochód").fontWeight(.bold).font(.system(size: 25))
                    
            }
            .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .global)
                .onEnded { value in
                    swipe(value)
                }).hiddenNavigationBarStyle()
        }
    
    private func swipe(_ value: DragGesture.Value) {
        let horizontalAmount = value.translation.width as CGFloat
        let verticalAmount = value.translation.height as CGFloat
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            //                        print(horizontalAmount > 0 ? "left swipe" : "right swipe")
            //                        if(horizontalAmount>0){
            //                            homeisActive.toggle()
            //                        }
        } else {
            //                        print(verticalAmount < 0 ? "up swipe" : "down swipe")
            if (verticalAmount>0) {
                homeisActive.toggle()
            }
        }
    }
    }
    


struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView()
            .previewInterfaceOrientation(.portrait)
    }
}
