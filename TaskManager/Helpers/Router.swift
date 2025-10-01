//
//  Router.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 01/10/25.
//
import SwiftUI

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
