//
//  SearchWorkHistoryService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation

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
                WorkHistory(menu: $0)
            }
        
    }
}

struct SearchWorkHistoryServicePreview : SearchWorkHistoryService {
    func exec(name : String) async -> [WorkHistory] {
        return [
            WorkHistory(menu: Menu(name: "menu1")),
            WorkHistory(menu: Menu(name: "menu2")),
            WorkHistory(menu: Menu(name: "menu3"))
        ]
    }
}
