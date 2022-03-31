//
//  RentView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI

struct RentView: View {
    @State var homeisActive = false
    
    
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Car.id, ascending: true)],
        animation: .default)private var cars: FetchedResults<Car>
    
 
    
    
 
    
    var body: some View {
        
        if homeisActive {
            NavigationLink(destination: ContentView(),label: {
                Text("Menu główne").foregroundColor(.black)
                Image("main.icon").resizable().frame(width: 25 , height: 25)
                
            })
              
            
            }
        
            VStack{
                colorsLine()
                Text("Wybierz Samochód").fontWeight(.bold).font(.system(size: 25))
                
                
                List {
                    ForEach(cars) { car in
                        
                        if(car.isAvailable){
                            NavigationLink(destination: RentResultView(car: car), label: {
                                CarRowView(car: car)})
                        }
                        }.listRowBackground(colorsLine())
                        .padding(5)
                    }
                
                    
            }
            .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .global).onEnded {
                value in swipe(value)}).hiddenNavigationBarStyle()
        }
    
    
    private func colorsLine() -> some View {
         return LinearGradient(gradient: Gradient(colors: [Color.white,Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
         .ignoresSafeArea(.all,edges: .all).frame(height: 80).cornerRadius(10)
     }
    
    
    private func swipe(_ value: DragGesture.Value) {
        let horizontalAmount = value.translation.width as CGFloat
        let verticalAmount = value.translation.height as CGFloat
        
        if abs(horizontalAmount) > abs(verticalAmount) {
            //                        print(horizontalAmount > 0 ? "left swipe" : "right swipe")
        } else {
            //                        print(verticalAmount < 0 ? "up swipe" : "down swipe")
            if (verticalAmount>0) {
                homeisActive.toggle()
            }
        }
    }
    }
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct RentView_Previews: PreviewProvider {
    static var previews: some View {
        RentView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct CarRowView: View {
    var car: Car

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(car.producent!)  \(car.model!)")
                .foregroundColor(.primary)
                .font(.headline)
            VStack(spacing: 2) {
                Text("Liczba miejsc: \(car.seats)")
                Text("Przebieg: \(car.mileage)")
                Text("Aktualny stan: \(availableValidation(isAvailable: car.isAvailable))")
                
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
        }
    }
    
    func availableValidation(isAvailable: Bool) -> String {
        if isAvailable {
            return "dostępny"
        }else{
            return "niedostepny"
        }
    }
}

