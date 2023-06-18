//
//  Container.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/06/03.
//

import SwiftUI
import Combine


struct Container {
    let services: Services
    var test : EditWorkoutObservable {
        get {
            EditWorkoutObservable(
                searchService: self.services.searchWorkoutService,
                editService: self.services.editWorkoutService
            )
        }
    }
    
    func createEditWorkoutObservable() -> EditWorkoutObservable {
        return EditWorkoutObservable(
            searchService: self.services.searchWorkoutService,
            editService: self.services.editWorkoutService
        )
    }
    
    func createWorkoutCollectionViewObservable() -> WorkoutCollectionViewObservable {
        return WorkoutCollectionViewObservable(
            collectionService: self.services.collectionWorkoutService,
            editService: self.services.editWorkoutService
        )
    }
}

extension Container: EnvironmentKey {
    static var defaultValue: Self { Self.default }
    private static let `default` = Self(services: .preview)
}

extension EnvironmentValues {
    var injected: Container {
        get { self[Container.self] }
        set { self[Container.self] = newValue }
    }
}

extension View {
    func inject(_ container: Container) -> some View {
        return self
            .environment(\.injected, container)
    }
}

@propertyWrapper
struct ObservableState<T> where T : ObservableObject {
    @Environment(\.injected) var injected : Container
    let keyPath : KeyPath<Container, T>
    var wrappedValue: T {
        get {
            projectedValue.wrappedValue
        }
    }
    
    lazy var projectedValue: StateObject<T> = {
        let value = injected[keyPath: keyPath]
        return StateObject(wrappedValue: value)
    }()
    
    init(_ keyPath : KeyPath<Container, T>) {
        self.keyPath = keyPath
    }
}
