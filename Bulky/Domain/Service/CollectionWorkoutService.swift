//
//  CollectionWorkoutService.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/26.
//

import Foundation

protocol CollectionWorkoutService {
    func exec() async -> [Workout]
}

struct CollectionWorkoutServicePreview : CollectionWorkoutService {
    func exec() async -> [Workout] {
        return [
            Workout(menu: Menu(name: "menu1")),
            Workout(menu: Menu(name: "menu2")),
            Workout(menu: Menu(name: "menu3"))
        ]
    }
}
