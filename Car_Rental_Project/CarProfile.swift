//
//  CarProfile.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 30/03/2022.
//
import MapKit
import SwiftUI


struct CarProfile: View {
    
    var car: Car

    @State var places =  [Place(coordinate: CLLocationCoordinate2D(
                 latitude: 51.23572314762387,
                 longitude: 22.550248826718523))]
    
    @State var region : MKCoordinateRegion = MKCoordinateRegion (
        center: CLLocationCoordinate2D(
            latitude: 51.23572314762387,
            longitude: 22.550248826718523),
        latitudinalMeters: 300,
        longitudinalMeters: 300)
    
    
  
    
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
                       
                       Text("Lokalizacja: ")
                       Map(coordinateRegion: $region, annotationItems: places){
                          place in
                           MapMarker(coordinate: place.coordinate, tint: Color.green)
                      }.frame(width:350, height: 280, alignment: .center)
                       
                       Button(action: {
                           self.places = [Place(coordinate: CLLocationCoordinate2D(
                            latitude: Double(car.latitude!)!,
                            longitude: Double(car.longitude!)!))]
                           
                           self.region = MKCoordinateRegion(
                               center: CLLocationCoordinate2D(
                                latitude: Double(car.latitude!)!,
                                longitude: Double(car.longitude!)!),
                               latitudinalMeters: 600,
                               longitudinalMeters: 600)
                           
                       }, label: {Text("Zlokalizuj")})
                   }
               }
           }
    
    
    
    }




