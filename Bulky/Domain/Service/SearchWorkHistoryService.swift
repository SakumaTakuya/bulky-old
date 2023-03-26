//
//  SearchWorkHistoryService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation

struct WorkHistory {
    let menu : Menu
    let sets : [Exercise]
}

protocol SearchWorkHistoryService {
    func exec(name : String) async -> [WorkHistory]
}

struct SearchWorkHistoryServiceDefault {
    let workoutRepository : WorkoutRepository
    let menuRepository : MenuRepository
    
    init(workoutRepository: WorkoutRepository, menuRepository: MenuRepository) {
        self.workoutRepository = workoutRepository
        self.menuRepository = menuRepository
    }
}

extension SearchWorkHistoryServiceDefault : SearchWorkHistoryService {
    func exec(name : String) async -> [WorkHistory] {
        let workouts = await workoutRepository.search(name: name)
        
        if (workouts.count > 0) {
            return workouts.map {
                WorkHistory(menu: $0.menu, sets: $0.sets)
            }
        }
        
        return await menuRepository
            .search(name: name)
            .map{
                WorkHistory(menu: $0, sets: [])
            }
        
    }
}
