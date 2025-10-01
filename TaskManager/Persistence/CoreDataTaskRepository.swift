//
//  CoreDataTaskRepository.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import Foundation
import CoreData

final class CoreDataTaskRepository: TaskRepository {
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext { container.viewContext }
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
    
    func add(_ item: TaskItem) async throws {
        var thrown: Error?
        
        await container.performBackgroundTask { ctx in
            do {
                let obj = CDTask(context: ctx)
                obj.id = item.id
                obj.title = item.title
                obj.isDone = item.isDone
                obj.createdAt = item.createdAt
                
                if ctx.hasChanges { try ctx.save() }
            } catch {
                thrown = error
            }
        }
        
        if let e = thrown { print(e.localizedDescription) }
    }
    
    func fetchAll() async throws -> [TaskItem] {
        let req: NSFetchRequest<CDTask> = CDTask.fetchRequest()
        
        let objs = try context.fetch(req)
        return objs.compactMap({ $0.toDomain()})
    }
    
    func toggleDone(id: UUID) async throws {
        var thrown: Error?
        
        await container.performBackgroundTask { ctx in
            do {
                if let obj = try self.find(by: id, ctx: ctx) {
                    obj.isDone.toggle()
                    if ctx.hasChanges { try ctx.save() }
                }
            } catch {
                thrown = error
            }
        }
        
        if let e = thrown { print(e.localizedDescription) }
    }
    
    func delete(id: UUID) async throws {
        var thrown: Error?
        
        await container.performBackgroundTask { ctx in
            do {
                if let obj = try self.find(by: id, ctx: ctx) {
                    ctx.delete(obj)
                    if ctx.hasChanges { try ctx.save() }
                }
            } catch {
                thrown = error
            }
        }
        
        if let e = thrown { print(e.localizedDescription) }
    }
    
    // MARK: Helpers
    
    func find(by id: UUID, ctx: NSManagedObjectContext) throws  -> CDTask? {
        let req: NSFetchRequest<CDTask> = CDTask.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        req.fetchLimit = 1
        return try ctx.fetch(req).first
    }
    
    func saveIdNeeded() throws {
        if context.hasChanges { try context.save() }
    }
}
