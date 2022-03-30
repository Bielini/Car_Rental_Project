//
//  CarProfile.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 30/03/2022.
//

import SwiftUI


struct CarProfile: View {
    
    var car: Car

   
    
    var body: some View {
        ScrollView {
                   VStack(alignment: .leading, spacing: 10) {
                       Text("\(car.producent ?? "default") \(car.model ?? "default")")
                           .bold()
                           .font(.title)

                       Text("Producent: \(car.producent ?? "default")")
                       Text("Model: \(car.model ?? "default")")
                       Text("Przebieg: \(car.mileage)")
                       Text("Liczba miejsc: \(car.seats)")
                       Image("\(car.id)").resizable().frame(width: 350, height: 300, alignment: .center)
                   }
               }
           }
    
    }




