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
            colorsLine()
                
        VStack{
            Image("main.icon").resizable().padding()
            
            NavigationLink(
                destination: RentView().navigationBarBackButtonHidden(true),
                
                label: {
                    labelMaker(content: "Wypożycz auto")
                }
                
            ).padding(10)
            
            NavigationLink(
                destination: ReturnView().navigationBarBackButtonHidden(true),
                label: {
                    labelMaker(content: "Oddaj auto")
                        
                }
                
            ).padding(10)
            
            NavigationLink(
                destination: CarsManageView().navigationBarBackButtonHidden(true),
                label: {
                    labelMaker(content: "Dodaj auto")
                }
                
            ).padding(10)
            
            
                }
            }
        }.hiddenNavigationBarStyle()
    }
    
    
    private func colorsLine() -> some View {
         return LinearGradient(gradient: Gradient(colors: [Color.white,Color.red]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
         .ignoresSafeArea(.all,edges: .all).frame(height: 80).cornerRadius(10)
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
    
    func labelMaker(content: String) -> some View {
        return Text(content)
                .foregroundColor(Color.black)
                .frame(width: 180,height: 60)
                .background(Color.white)
                .cornerRadius(10)
                .font(.system(size: 20,weight: .bold))
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
struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}




