//
//  TaskRepositortTests.swift
//  TaskManagerTests
//
//  Created by Renoy Chowdhury on 29/09/25.
//

import XCTest
@testable import TaskManager

final class TaskRepositortTests: XCTestCase {
    private var sut: TaskRepository!
    
    private var factory: TestCoreDataFactory!
    
    override func setUp() {
        super.setUp()
        factory = TestCoreDataFactory()
        sut = CoreDataTaskRepository(container: factory.container)
    }
    
    override func tearDown() {
        sut = nil
        factory = nil
        super.tearDown()
    }
    
    func test_backgroundWrite_mergesIntoViewContext() async throws {
        let item = TaskItem(title: "BG Merge")
        try await sut.add(item)

        // Attendi un attimo che il background salvi e il main faccia merge
        let exp = expectation(description: "merge")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { exp.fulfill() }
        await fulfillment(of: [exp], timeout: 1.0)

        let loaded = try await sut.fetchAll()
        XCTAssertTrue(loaded.contains(where: { $0.id == item.id }))
    }
    
    func test_addAndFetch_roundTrip() async throws {
        let item = TaskItem(title: "TDD test")
        try await sut.add(item)
        
        let exp = expectation(description: "merge")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { exp.fulfill() }
        await fulfillment(of: [exp], timeout: 1.0)

        
        let loaded = try await sut.fetchAll()
        XCTAssertEqual(loaded, [item], "Dovrebbe avere l'item inserito")
    }
    
    func test_toggle_item() async throws {
        var item = TaskItem(title: "TDD test")
        item.isDone = true
        try await sut.add(item)
        
        let exp = expectation(description: "merge")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { exp.fulfill() }
        await fulfillment(of: [exp], timeout: 1.0)

        
        let loaded = try await sut.fetchAll()
        
        XCTAssertEqual(loaded.first?.isDone, item.isDone, "il campo is done dovrebbe essere uguale al valore fetchato")
    }
    
    func test_delete_item() async throws {
        var item = TaskItem(title: "TDD test")
        item.isDone = true
        try await sut.add(item)
        
        try await sut.delete(id: item.id)
        
//        let exp = expectation(description: "merge")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { exp.fulfill() }
//        await fulfillment(of: [exp], timeout: 1.0)
        
        let loaded = try await sut.fetchAll()
        
        let doesntContain = !(loaded.contains(where: {$0.id == item.id}))
        
        XCTAssertEqual(doesntContain, true, "loaded non dovrebbe avere l'item perchè è stato eliminato")
    }
    
    
}

private final class NotImplementedRepositoty: TaskRepository {
    func add(_ item: TaskManager.TaskItem) throws {
        XCTFail("not implemented")
    }
    
    func fetchAll() throws -> [TaskManager.TaskItem] {
        XCTFail("not implemented")
        return []
    }
    
    func toggleDone(id: UUID) throws {
        XCTFail("not implemented")
    }
    
    func delete(id: UUID) throws {
        XCTFail("not implemented")
    }
    
    
}
