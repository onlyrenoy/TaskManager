//
//  ContentView.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import SwiftUI
import CoreData

enum Routes: Hashable {
    case task
    case addTasks
    
    case notes
    case addNotes
    
    case categories
    case addCategories
    
    case settings
}

@MainActor
class Router: ObservableObject {
    @Published var path: NavigationPath = .init()
    
    func appear(route: Routes) {
        popToRoot()
        path.append(route)
    }
    
    func push(route: Routes) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    @ViewBuilder
    func view(_ route: Routes) -> some View {
        Group {
            switch route {
            case .task:
                ContentView()
            case .addTasks:
                ContentView()
            case .notes:
                ContentView()
            case .addNotes:
                ContentView()
            case .categories:
                ContentView()
            case .addCategories:
                ContentView()
            case .settings:
                ContentView()
            }
        }
        .environmentObject(self)
    }
    
}

struct ContentView: View {
    @EnvironmentObject var viewModel: TaskManagerViewModel
    @EnvironmentObject var coordinator: Router
    
    var body: some View {
        VStack {
            HStack {
                Button("+") {
                    coordinator.push(route: .addCategories)
                }
                .font(.title)
                .padding()
                Spacer()
                Text("Tasks")
                Spacer()
                Button("🔎") {
                    viewModel.add(title: "test")
                }
                .padding()
            }
            .background(Color.secondary)
            
            Spacer()
            if viewModel.items.isEmpty {
                Text("No items")
            } else {
                List(viewModel.items, id: \.id) { item in
                    Text("\(item.title)")
                }
            }
            
            Spacer()
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(TaskManagerViewModel(repo: CoreDataTaskRepository(container: CoreDataFactory().container)))
        .environmentObject(Router())
}

struct Page: View {
    
    
    var body: some View {
        VStack {
            
        }
    }
}
