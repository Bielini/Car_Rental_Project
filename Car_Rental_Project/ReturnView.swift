//
//  ReturnView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//
import MapKit
import SwiftUI
import Combine

struct ReturnView: View {
    @State var homeisActive = false
    @State private var showingAlert = false
    @State private var email: String = ""
    @State private var returnCode: String = ""
    @State private var rentInfo: String = ""
    @State var places =  [Place(coordinate: CLLocationCoordinate2D(
                 latitude: 51.23572314762387,
                 longitude: 22.550248826718523))]
    
    @State var region : MKCoordinateRegion = MKCoordinateRegion (
        center: CLLocationCoordinate2D(
            latitude: 51.23572314762387,
            longitude: 22.550248826718523),
        latitudinalMeters: 300,
        longitudinalMeters: 300)
    
    @State var latitude: String = ""
    @State var longitude: String = ""
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Car.id, ascending: true)],
        animation: .default) private var cars: FetchedResults<Car>
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Rent.email, ascending: true)],
        animation: .default) private var rents: FetchedResults<Rent>
    
    var body: some View {
        
        if homeisActive {
            NavigationLink(destination: ContentView(),label: {
                Text("Menu główne").foregroundColor(.black)
                Image("main.icon").resizable().frame(width: 25 , height: 25)
                
            })}
        
            VStack{
                colorsLine()
                Text("Zwrot Samochodu").fontWeight(.bold).font(.system(size: 25))
                Text("Podaj dane: ").fontWeight(.bold).font(.system(size: 20))
                
                TextField("Email: ", text: $email)
                TextField("Return Code: ", text: $returnCode)
                
                Map(coordinateRegion: $region, annotationItems: places){
                   place in
                    MapMarker(coordinate: place.coordinate, tint: Color.green)
               }.frame(width:380, height: 200, alignment: .center)
               
               Text("Wspólrzędne lokalizacji:")
               HStack{
               TextField("Szerokość -90:90",text: $latitude).keyboardType(.decimalPad)
                   .onReceive(Just(latitude)) { newValue in
                                   let filtered = newValue.filter { "0123456789.".contains($0) }
                                   if filtered != newValue {
                                       self.latitude = filtered
                                   }
                           }
               TextField("Długość -180:180",text: $longitude).keyboardType(.decimalPad)
                   .onReceive(Just(longitude)) { newValue in
                                   let filtered = newValue.filter { "0123456789.".contains($0) }
                                   if filtered != newValue {
                                       self.longitude = filtered
                                   }
                           }
               }
                Button(action: {
                    if  longitude != "" && latitude != "" {
                        
                        self.places = [Place(coordinate: CLLocationCoordinate2D(
                            latitude: Double(latitude)!,
                            longitude: Double(longitude)!))]
                        
                        self.region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: Double(latitude)!,
                                longitude: Double(longitude)!),
                            latitudinalMeters: 300,
                            longitudinalMeters: 300)
                    }
                }, label: {Text("Zlokalizuj")})
                
                Button(action: deleteCar){
                    Text("Zwróć samochód")
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Alert"), message: Text("Wypełnij wszystkie pola"), dismissButton: .default(Text("Wróć")))
                }
                
                
                    
            }.gesture(DragGesture(minimumDistance: 10, coordinateSpace: .global)
                .onEnded { value in
                   swipe(value)
                }).hiddenNavigationBarStyle()
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
    private func deleteCar() {withAnimation {
        if email != "" && returnCode != "" && longitude != "" && latitude != "" {
            
            rents.forEach { rent in
                
                if(rent.returnCode == returnCode){
                    
                    viewContext.delete(rent)
                    rent.toCar?.longitude = longitude
                    rent.toCar?.latitude = latitude
                    rent.toCar?.isAvailable = true
                   
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
                        }
                    }
                }
            longitude = ""
            latitude = ""
            returnCode = ""
            email = ""
            
           
            showingAlert = false
        }else{
            showingAlert = true
        }
            }
        }
    
    
}


struct ReturnView_Previews: PreviewProvider {
    static var previews: some View {
        ReturnView()
    }
}

