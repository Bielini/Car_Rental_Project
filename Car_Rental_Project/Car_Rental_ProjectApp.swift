//
//  Car_Rental_ProjectApp.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import SwiftUI

@main
struct Car_Rental_ProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
