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
    let searchService : SearchWorkHistoryService
    
    init(data: WorkoutEditData = WorkoutEditData()) {
        self.data = data
        self.searchService = SearchWorkHistoryServicePreview()
    }
    
    func search(request : String) -> [String] {
        Task {
            let result = await searchService.exec(name: request)
            result.map { vale in
                historyMap[
            }
        }
        
        
        
        return []
    }
}
