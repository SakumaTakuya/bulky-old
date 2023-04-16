//
//  SearchWorkHistoryService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation

protocol SearchWorkHistoryService {
    func exec(name : String) async -> [WorkoutHistory]
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
    func exec(name : String) async -> [WorkoutHistory] {
        let workouts = await workoutRepository.search(name: name)
        
        if (workouts.count > 0) {
            return workouts.map {
                WorkoutHistory(menu: $0.menu, sets: $0.sets)
            }
        }
        
        return await menuRepository
            .search(name: name)
            .map{
                WorkoutHistory(menu: $0)
            }
        
    }
}

struct SearchWorkHistoryServicePreview : SearchWorkHistoryService {
    func exec(name : String) async -> [WorkoutHistory] {
        return [
            WorkoutHistory(menu: Menu(name: "menu1")),
            WorkoutHistory(menu: Menu(name: "menu2")),
            WorkoutHistory(menu: Menu(name: "menu3"))
        ]
    }
}
