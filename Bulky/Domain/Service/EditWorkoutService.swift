//
//  EditWorkoutService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import Combine

protocol EditWorkoutService {
    func exec(data : WorkoutEditData) async -> Void
}

struct EditWorkoutDefaultService {
    let workoutRepository : WorkoutRepository
    let menuRepository : MenuRepository
    
    init(workoutRepository: WorkoutRepository, menuRepository: MenuRepository) {
        self.workoutRepository = workoutRepository
        self.menuRepository = menuRepository
    }
}

extension EditWorkoutDefaultService : EditWorkoutService {
    func exec(data: WorkoutEditData) async {
        guard let menu = await menuRepository.get(name: data.name) else {
            let created = await menuRepository.store(
                item: Menu(name: data.name, alts: [])
            )
            return await workoutRepository.store(item: Workout(
                menu: created,
                date: data.date,
                sets: data.sets,
                id: data.id
            ))
        }
        
        await workoutRepository.store(item: Workout(
            menu: menu,
            date: data.date,
            sets: data.sets,
            id: data.id
        ))
    }
}

struct EditWorkoutServicePreview : EditWorkoutService {
    func exec(data : WorkoutEditData) async -> Void {
        
    }
}
