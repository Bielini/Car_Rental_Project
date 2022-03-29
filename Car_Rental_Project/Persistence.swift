//
//  Persistence.swift
//  Car_Rental_Project
//
//  Created by Piotrek Bielawski on 29/03/2022.
//

import CoreData

struct Persistence {
    
    static let shared = Persistence()
    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "db")
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
