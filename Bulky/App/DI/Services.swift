//
//  Services.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/06/03.
//

import Foundation

struct Services {
    let createWorkoutService: CreateWorkoutService
    let searchWorkoutService: SearchWorkHistoryService
    let editWorkoutService: EditWorkoutService
    let collectionWorkoutService: CollectionWorkoutService
    
    static var preview: Self {
        .init(
             createWorkoutService: CreateWorkoutServicePreview(),
             searchWorkoutService: SearchWorkHistoryServicePreview(),
             editWorkoutService: EditWorkoutServicePreview(),
             collectionWorkoutService: CollectionWorkoutServicePreview()
        )
    }
}
