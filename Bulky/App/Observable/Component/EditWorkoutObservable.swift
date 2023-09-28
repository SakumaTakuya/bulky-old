//
//  CreateWorkoutObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation


class EditWorkoutObservable : ObservableObject {
    @Published var data : WorkoutEditData
    @Published var historyMap: Dictionary<String, WorkoutHistory> = [:]
    @Published var searchResults: [Workout] = []
    let searchService : SearchWorkHistoryService
    var scale: Int {
        get {
            Int(searchResults.map {
                $0.sets.max(by: {a, b in
                    a.weight < b.weight
                })?.weight ?? 0
            }.max(by: {a, b in a < b}) ?? 0)
        }
    }
    
    init(data: WorkoutEditData = WorkoutEditData()) {
        self.data = data
        self.searchService = SearchWorkHistoryServicePreview()
    }
    
    func search(request : String) {
        searchResults = [
            Workout(menu: Menu(name: "Test1"), sets: [Exercise(weight: 112, rest: 10, reps: 10), Exercise(weight: 112, rest: 10, reps: 10)]),
            Workout(menu: Menu(name: "Test1"), sets: [Exercise(weight: 12, rest: 10, reps: 10)]),
            Workout(menu: Menu(name: "Test1"), sets: [Exercise(weight: 112, rest: 1, reps: 10)]),
            Workout(menu: Menu(name: "Test1"), sets: [Exercise(weight: 2, rest: 10, reps: 1)]),
            Workout(menu: Menu(name: "Test2")),
            Workout(menu: Menu(name: "Test3")),
            Workout(menu: Menu(name: "Test1")),
            Workout(menu: Menu(name: "Test1")),Workout(menu: Menu(name: "Test1")),Workout(menu: Menu(name: "Test1")),Workout(menu: Menu(name: "Test1")),
        ]
    }
}
