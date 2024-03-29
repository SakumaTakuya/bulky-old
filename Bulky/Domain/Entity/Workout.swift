//
//  Workout.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation

struct Workout : Codable, Hashable, Identifiable {
    let id : UUID
    let menu : Menu
    let date : Date
    let sets : [Exercise]
    
    init(
        menu: Menu,
        date: Date = .now,
        sets: [Exercise] = [],
        id: UUID? = nil
    ) {
        self.id = id ?? UUID()
        self.menu = menu
        self.date = date
        self.sets = sets
    }
}


