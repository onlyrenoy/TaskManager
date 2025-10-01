//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import SwiftUI

@main
struct TaskManagerApp: App {
    @StateObject var coordinator: Router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                ContentView()
                    .navigationDestination(for: Routes.self) { route in
                        coordinator.view(route)
                    }
                    .sheet(item: $coordinator.sheet) { modal in
                        coordinator.modalView(modal)
                    }
            }
            .environmentObject(coordinator)
        }
    }
}

@MainActor
class TaskManagerViewModel: ObservableObject {
    @Published var items: [TaskItem] = []
    let repo: TaskRepository
    
    init(repo: TaskRepository) {
        self.repo = repo
        load()
    }
    
    func load() {
        Task { [weak self] in
            guard let self else { return }
            self.items = try await repo.fetchAll()
        }
    }
    
    func add(title: String) {
        Task { [weak self] in
            guard let self else { return }
            let item = TaskItem(title: title)
            try await self.repo.add(item)
            self.items = try await self.repo.fetchAll()
        }
    }
    
}
