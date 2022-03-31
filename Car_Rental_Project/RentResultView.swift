//
//  RentResultView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 31/03/2022.
//

import SwiftUI


struct RentResultView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Car.id, ascending: true)],
        animation: .default) private var cars: FetchedResults<Car>
    
    @FetchRequest(
        sortDescriptors:[NSSortDescriptor(keyPath:\Rent.email, ascending: true)],
        animation: .default) private var rents: FetchedResults<Rent>
    
    var car: Car
    
    @State private var showingAlert = false
    @State private var email: String = ""
    @State private var returnCode: String = ""
    @State private var rentInfo: String = ""
    
    
    

    
    var body: some View {
        VStack{
            colorsLine()
            Text("Podaj dane").fontWeight(.bold).font(.system(size: 25))
            
            TextField("Email: ", text: $email)
            TextField("Return Code: ", text: $returnCode)
            
            
            Button(action: rentCar){
                Text("Wypożycz")
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Alert"), message: Text("Wypełnij wszystkie pola"), dismissButton: .default(Text("Wróć")))}
            
            
            
            }
        }
    
    
    
    
   
    private func rentCar(){
        
        if email != "" && returnCode != ""  {
            
            let newRent = Rent(context: viewContext)
           
            
            newRent.email = email
            newRent.returnCode = returnCode
            newRent.toCar = car
            newRent.toCar?.isAvailable = false
            
            
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
            }
 
            returnCode = ""
            email = ""
            showingAlert = false
        }else{
            showingAlert = true
        }
    }
    
    private func colorsLine() -> some View {
         return LinearGradient(gradient: Gradient(colors: [Color.white,Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
         .ignoresSafeArea(.all,edges: .all).frame(height: 80).cornerRadius(10)
     }
}

struct RentRowView: View {
    var rent: Rent

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("\(rent.returnCode!)searae")
                .foregroundColor(.primary)
                .font(.headline)
           
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
        }
    }
    
   
    



