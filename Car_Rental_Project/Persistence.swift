//
//  Persistence.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import CoreData

class Persistence: ObservableObject {
    
    static let shared = Persistence()
    
    let container = NSPersistentContainer(name: "db")

    init() {

        container.loadPersistentStores{ (description, error) in
            if let error = error {
                fatalError("Error:  \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in})
    {
        let context = container.viewContext
        if context.hasChanges{
            do {
                try context.save()
                completion(nil)
            } catch  {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        
        let context = container.viewContext
        
        context.delete(object)
        save(completion: completion)
    }
 
}
