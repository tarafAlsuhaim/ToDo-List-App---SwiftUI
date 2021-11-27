//
//  MyTodoListApp.swift
//  MyTodoList
//
//  Created by Najla Talal on 11/4/21.
//

import SwiftUI

@main
struct MyTodoListApp: App {
    let persistantContainer = CoreDataManager.shared.persistantContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}
