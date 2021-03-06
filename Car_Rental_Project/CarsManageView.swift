//
//  AddCarrView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI
import Combine


struct CarsManageView: View {
    @State var homeisActive = false
    @State var addButton = "Dodaj samochód"
    
    @State private var isAvailable: String = ""
    @State private var showingAlert = false
    
    @State private var model: String = ""
    @State private var producent: String = ""
    @State private var id: String = ""
    @State private var mileage = ""
    @State private var seats = 0
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Car.id, ascending: true)],
        animation: .default)
    private var cars: FetchedResults<Car>
    
 
  
    
    var body: some View {
        
        if homeisActive {
            NavigationLink(destination: ContentView(),label: {
                Text("Menu główne").foregroundColor(.black)
                Image("main.icon").resizable().frame(width: 25 , height: 25)
            })}
        
        
        
        
        
        VStack{
           
            colorsLine()
            Text("Zarządzanie Samochodami").fontWeight(.bold).font(.system(size: 25))
            
            Section {
                
               
                TextField("Producent: ", text: $producent)
                TextField("Model: ", text: $model)
                TextField("Przebieg: ", text: $mileage)
                    .keyboardType(.decimalPad)
                    .onReceive(Just(mileage)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.mileage = filtered
                                    }
                            }
                Picker("Liczba miejsc: ",selection: $seats) {
                    ForEach(1 ..< 11) {
                        Text("Liczba miejsc: \($0) ")
                    }
                }
            }
            
           
            
            Button(action: addCar){
                Text("Dodaj samochód")
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Alert"), message: Text("Wypełnij wszystkie pola"), dismissButton: .default(Text("Wróć")))
            }
           
            List{
                ForEach(cars){ car in
                    
                    NavigationLink(destination: CarProfile(car: car), label: {
                        CarRowView(car: car)})
                    
                }
                    .onDelete(perform: deleteCar)
                    .padding(5)
                    .listRowBackground(colorsLine())
                    
            }
        }
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global)
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

    
    private func addCar(){
        
        if model != "" && producent != "" && mileage != ""  {
            
            let newCar = Car(context: viewContext)
            if(cars.isEmpty){
                newCar.id=1
            }else{
                newCar.id = (cars.last?.id)!+1
            }
            
            newCar.model = model
            newCar.producent = producent
            newCar.mileage = Int16(mileage) ?? 0
            
            newCar.seats = Int16(seats+1)
            newCar.isAvailable = true
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
            }
           
            model = ""
            producent = ""
            mileage = ""
            id = ""
            seats = 0
            showingAlert = false
        }else{
            showingAlert = true
        }
    }
    
    private func deleteCar(offsets: IndexSet) {withAnimation {
        
        let isAvailableCurrent = offsets.map {cars[$0].isAvailable}.last
        
        if(isAvailableCurrent!){
        offsets.map { cars[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
        }
        }
    }
        
    }
}


struct CarsManageView_Previews: PreviewProvider {
    static var previews: some View {
        CarsManageView()
    }
}


