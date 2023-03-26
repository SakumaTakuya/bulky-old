//
//  DataSource.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/15.
//

import CoreData
import Combine

protocol DataSource {
    typealias DBOperation<Result> = (NSManagedObjectContext) throws -> Result
    
    func count<T>(_ fetchRequest: NSFetchRequest<T>) -> AnyPublisher<Int, Error>
    func fetch<T, V>(_ fetchRequest: NSFetchRequest<T>,
                     map: @escaping (T) throws -> V?) -> AnyPublisher<V, Error>
    func update<Result>(_ operation: @escaping DBOperation<Result>) -> AnyPublisher<Result, Error>
}

//struct CoreDataSource : DataSource {
//    private let container: NSPersistentContainer
//    private let isStoreLoaded = CurrentValueSubject<Bool, Error>(false)
//    private let bgQueue = DispatchQueue(label: "coredata")
//        
//    init() {
//        container = NSPersistentContainer(name: "Bulky")
//    }
//}
