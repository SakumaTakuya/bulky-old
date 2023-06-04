//
//  CreateWorkoutObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation


class EditWorkoutObservable : ObservableObject {
    @Published var searched: [Workout] = []
    @Published var data: WorkoutEditData
    
    let searchService: SearchWorkHistoryService
    let editService: EditWorkoutService
    
    init(
        searchService: SearchWorkHistoryService,
        editService: EditWorkoutService,
        data: Workout? = nil
    ) {
        self.searchService = searchService
        self.editService = editService
        switch data {
        case let data?: self.data = WorkoutEditData(
            id: data.id,
            name: data.menu.name,
            date: data.date,
            sets: data.sets
        )
        default: self.data = WorkoutEditData()
        }
    }
    
    func search(request : String) {
        Task {
            searched = await self.searchService.exec(name: request)
        }
    }
    
    func addExercise() {
        if let last = self.data.sets.last {
            self.data.sets.append(
                Exercise(weight: last.rest, rest: last.rest, reps: last.reps)
            )
        } else {
            self.data.sets.append(
                Exercise(weight: 0, rest: 0, reps: 0)
            )
        }
    }
    
    func select(selected : Selection<Workout>) {
        switch selected {
        case let .New(request):
            self.data.name = request
        case let .Searched(workout): self.data = WorkoutEditData(
            id: workout.id,
            name: workout.menu.name,
            date: self.data.date,
            sets: workout.sets
        )
        }
    }
    
    func submit() {
        Task {
            await self.editService.exec(data: self.data)
        }
    }
}
