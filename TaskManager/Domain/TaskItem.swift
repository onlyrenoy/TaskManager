//
//  TaskItem.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import Foundation

public struct TaskItem: Equatable {
    public let id: UUID
    public var title: String
    public var isDone: Bool
    public var createdAt: Date
    
    public init(id: UUID = UUID(), title: String, isDone: Bool = false, createdAt: Date = .now) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}

public protocol TaskRepository{
    func add(_ item: TaskItem) async throws
    func fetchAll() async throws -> [TaskItem]
    func toggleDone(id: UUID) async throws
    func delete(id: UUID) async throws
}
