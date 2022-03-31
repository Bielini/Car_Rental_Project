//
//  ReturnView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI

struct ReturnView: View {
    @State var homeisActive = false
    @State private var showingAlert = false
    @State private var email: String = ""
    @State private var returnCode: String = ""
    @State private var rentInfo: String = ""
    
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
                
                Button(action: deleteCar){
                    Text("Zwróć samochód")
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Alert"), message: Text("Wypełnij wszystkie pola"), dismissButton: .default(Text("Wróć")))
                }
                
                Text("\(rentInfo)")
                    
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
        if email != "" && returnCode != ""  {
            
            rents.forEach { rent in
                
                if(rent.returnCode == returnCode){
                    
                    viewContext.delete(rent)
                    rent.toCar?.isAvailable = true
                   
                    
                    do {
                        try viewContext.save()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError),\(nsError.userInfo)")
                        }
                    }
                }
            
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

