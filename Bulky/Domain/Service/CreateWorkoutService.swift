//
//  CreateWorkoutService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation
import Combine

protocol CreateWorkoutService {
    func exec(name : String, date : Date, sets : [Exercise]) async -> Void
}

struct CreateWorkoutServiceDefault {
    let workoutRepository : WorkoutRepository
    let menuRepository : MenuRepository
    
    init(workoutRepository: WorkoutRepository, menuRepository: MenuRepository) {
        self.workoutRepository = workoutRepository
        self.menuRepository = menuRepository
    }
}

extension CreateWorkoutServiceDefault : CreateWorkoutService {
    func exec(name : String, date : Date, sets : [Exercise]) async -> Void {
        guard let menu = await menuRepository.get(name: name) else {
            let created = await menuRepository.store(item: Menu(name: name, alts: []))
            return await workoutRepository.store(item: Workout(
                menu: created,
                date: date,
                sets: sets
            ))
        }
    
        return await workoutRepository.store(item: Workout(
            menu: menu,
            date: date,
            sets: sets
        ))
    }
}

struct CreateWorkoutServicePreview : CreateWorkoutService {
    func exec(name : String, date : Date, sets : [Exercise]) async -> Void {
        
    }
}
