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
            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), label: {Text("back")})
            
            }
        
            VStack{
                Text("RentView")
                    
            }
            .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .global)
                .onEnded { value in
                    let horizontalAmount = value.translation.width as CGFloat
                    let verticalAmount = value.translation.height as CGFloat
                    
                    if abs(horizontalAmount) > abs(verticalAmount) {
                        print(horizontalAmount < 0 ? "left swipe" : "right swipe")
                        if(horizontalAmount<0){
                            print("1")
                            homeisActive.toggle()
                            
                            
                        }
                    } else {
                        print(verticalAmount < 0 ? "up swipe" : "down swipe")
                    }
                })
                
            
        }
    }
    


struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView()
            .previewInterfaceOrientation(.portrait)
    }
}
