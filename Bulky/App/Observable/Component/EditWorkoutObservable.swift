//
//  CreateWorkoutObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation


class EditWorkoutObservable : ObservableObject {
    @Published var data : WorkoutEditData
    
    init(data: WorkoutEditData = WorkoutEditData()) {
        self.data = data
    }
}
