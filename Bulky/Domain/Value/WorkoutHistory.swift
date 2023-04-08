//
//  WorkoutHistory.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/04/08.
//

import Foundation

struct WorkHistory {
    let menu : Menu
    let sets : [Exercise]
    
    
    init(menu: Menu, sets: [Exercise] = []) {
        self.menu = menu
        self.sets = sets
    }
}
