//
//  CreateWorkoutObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation


class EditWorkoutObservable : ObservableObject {
    @Published var data : WorkoutEditData
    @Published var historyMap: Dictionary<String, WorkoutHistory>
    
    init(data: WorkoutEditData = WorkoutEditData()) {
        self.data = data
    }
    
    func search(request : String) -> [String] {
        return []
    }
}
