//
//  WorkoutEditData.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation

struct WorkoutEditData {
    var id : UUID?
    var name : String
    var date : Date
    var sets : [Exercise]
    
    init(
        id: UUID? = nil,
        name: String = "new menu",
        date: Date = .now,
        sets: [Exercise] = []
    ) {
        self.id = id
        self.name = name
        self.date = date
        self.sets = sets
    }
    
    init (workout : Workout) {
        self.id = workout.id
        self.name = workout.menu.name
        self.date = workout.date
        self.sets = workout.sets
    }
}
