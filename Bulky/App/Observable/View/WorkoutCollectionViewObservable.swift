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
        Task {
            workouts = 
            
            
            await editService.exec(data: data)
        }
    }
}
