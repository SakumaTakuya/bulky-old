//
//  WorkoutCollectionViewObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/28.
//

import Foundation


class WorkoutCollectionViewObservable: ObservableObject {
    let collectionService : CollectionWorkoutService
    let editService: EditWorkoutService
//    let deleteService: DeleteWorkoutService
    
    @Published var workouts: [Workout] = []
    
    init(collectionService: CollectionWorkoutService, editService: EditWorkoutService) {
        self.collectionService = collectionService
        self.editService = editService
    }
    
    func update(data : WorkoutEditData) {
        let newItem = Workout(
            menu: Menu(name: data.name, alts: []),
            date: data.date,
            sets: data.sets,
            id: data.id
        )
        
        if (workouts.contains { $0.id == data.id }) {
            workouts = workouts.map { $0.id == data.id ? newItem : $0 }
        } else {
            workouts.append(newItem)
        }
        
        Task {
            await editService.exec(data: data)
        }
    }
    
    func delete(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
}
