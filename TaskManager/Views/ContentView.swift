//
//  ContentView.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import SwiftUI

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

