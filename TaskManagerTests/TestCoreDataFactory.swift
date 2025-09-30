//
//  TestCoreDataFactory.swift
//  TaskManagerTests
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import XCTest
import CoreData
@testable import TaskManager

final class TestCoreDataFactory {

    let container: NSPersistentContainer
    
    init(file: StaticString = #file, line: UInt = #line) {
        let bundlesToSearch = [
            Bundle(for: CDTask.self),   // bundle dell’app
            Bundle.main                 // host app (se valido)
        ]
        
        guard let modelURL = bundlesToSearch
            .compactMap({ $0.url(forResource: "TaskManager", withExtension: "momd") })
            .first,
              let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            XCTFail("imposibile caricare modello", file: file, line: line)
            fatalError()
        }
        
        container = NSPersistentContainer(name: "TaskManager", managedObjectModel: model)
        
        let desc = NSPersistentStoreDescription()
        desc.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [desc]
        
        container.loadPersistentStores { _, error in
            if let error = error {
                XCTFail("Caricamento store fallito: \(error.localizedDescription)", file: file, line: line)
            }
            
            self.container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
            self.container.viewContext.automaticallyMergesChangesFromParent = true
        }
        
    }
    
}

// Serve solo per recuperare il bundle del test
private final class DummyBundleToken {}
