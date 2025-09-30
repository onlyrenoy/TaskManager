//
//  CDTask+CoreDataClass.swift
//  TaskManager
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import Foundation
import CoreData

@objc
public class CDTask: NSManagedObject {}

extension CDTask {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTask> {
        NSFetchRequest<CDTask>(entityName: "CDTask")
    }
    
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var createdAt: Date?
}

extension CDTask {
    func toDomain() -> TaskItem? {
        guard let id = self.id, let createdAt = self.createdAt else { return nil }
        return TaskItem(id: id, title: self.title ?? "", isDone: self.isDone, createdAt: createdAt)
    }
}
