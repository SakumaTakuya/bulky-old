//
//  SearchWorkHistoryService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation

protocol SearchWorkHistoryService {
    func exec(name : String) async -> [Workout]
}

struct SearchWorkHistoryServiceDefault {
    let workoutRepository : WorkoutRepository
    
    init(workoutRepository: WorkoutRepository) {
        self.workoutRepository = workoutRepository
    }
}

extension SearchWorkHistoryServiceDefault : SearchWorkHistoryService {
    func exec(name : String) async -> [Workout] {
        return await workoutRepository.search(name: name)
    }
}

struct SearchWorkHistoryServicePreview : SearchWorkHistoryService {
    func exec(name : String) async -> [Workout] {
        return [
            Workout(menu: Menu(name: "menu1")),
            Workout(menu: Menu(name: "menu2")),
            Workout(menu: Menu(name: "menu3"))
        ]
    }
}
