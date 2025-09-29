//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
