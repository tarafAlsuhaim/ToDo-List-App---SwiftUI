//
//  CoreDataManager.swift
//  MyTodoList
//
//  Created by Najla Talal on 11/4/21.
//


import CoreData

class CoreDataManager {
    
    
    let persistantContainer:  NSPersistentContainer
    static let shared: CoreDataManager = CoreDataManager()
    
    private init() {
        persistantContainer = NSPersistentContainer(name: "TaskDatabase")
        persistantContainer.loadPersistentStores { discription, error in
            if let error = error {
                fatalError("Unable to load data \(error.localizedDescription)")
            }
        }
    }
}
