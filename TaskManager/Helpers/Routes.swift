//
//  Routes.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 01/10/25.
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
