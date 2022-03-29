//
//  ContentView.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Car.id, ascending: true)],
        animation: .default)
    private var cars: FetchedResults<Car>

    var body: some View {
        
        
        NavigationView{
            ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.red,Color.blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea(.all,edges: .all)
                
        VStack{
            Image("main.icon").resizable().padding()
            
            NavigationLink(
                destination: exampleView(),
                label: {
                    Text("Wypożycz auto")
                        .foregroundColor(Color.black)
                        .frame(width: 180,height: 60,alignment: .center)
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.system(size: 20,weight: .bold))
                        
                }
                
            ).padding(10)
            
            NavigationLink(
                destination: exampleView(),
                label: {
                    Text("Oddaj auto")
                        .foregroundColor(Color.black)
                        .frame(width: 180,height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.system(size: 20,weight: .bold))
                        
                }
                
            ).padding(10)
            
            NavigationLink(
                destination: exampleView(),
                label: {
                    Text("Dodaj auto")
                        .foregroundColor(Color.black)
                        .frame(width: 180,height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(.system(size: 20,weight: .bold))
                        
                }
                
            ).padding(10)
            
            
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Car(context: viewContext)
            newItem.id = 1

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { cars[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
        }
    }
}
struct exampleView: View{
    var body: some View{
        Text("wypożyczenie")
    }
}




