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

enum ModalRoutes: Identifiable {
    var id: String { String(describing: self) }
    
    case addTasks
    case addNotes
    case addCategories
}

@MainActor
class Router: ObservableObject {
    @Published var path: NavigationPath = .init()
    @Published var sheet: ModalRoutes? = nil
    
    func presentSheet(_ modal: ModalRoutes) {
        sheet = modal
    }
    
    func dismissSheet() {
        sheet = nil
    }
    
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
    
    @ViewBuilder
    func modalView(_ route: ModalRoutes) -> some View {
        switch route {
        case .addTasks:
            VStack { Text("Test")}.padding()
        case .addNotes:
            VStack { Text("Test")}.padding()
        case .addCategories:
            VStack { Text("Test")}.padding()
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel =  TaskManagerViewModel(repo: CoreDataTaskRepository(container: CoreDataFactory().container))
    @EnvironmentObject var coordinator: Router
    
    var body: some View {
        VStack() {
            HStack {
                Button("+") {
                    coordinator.presentSheet(.addTasks)
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
                    TaskView(item: item)
                }
                .ignoresSafeArea()
            }
            
            Spacer()
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(Router())
}

struct TaskView: View {
    @State var item: TaskItem
    
    var body: some View {
        HStack {
            VStack {
                Text("\(item.title)")
                Text("category")
            }
            Spacer()
            Image(uiImage: .checkmark)
        }
        .padding()
    }
}
