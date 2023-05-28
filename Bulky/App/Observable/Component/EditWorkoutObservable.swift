//
//  CreateWorkoutObservable.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation


class EditWorkoutObservable : ObservableObject {
    @Published var data : WorkoutEditData
    @Published var searched: [String] = []
    @Published var historyMap: Dictionary<String, Workout>
    
    let searchService: SearchWorkHistoryService
    
    init(
        data: WorkoutEditData = WorkoutEditData(),
        service: SearchWorkHistoryService
    ) {
        self.data = data
        self.historyMap = Dictionary()
        self.searchService = service
    }
    
    func search(request : String) {
        Task {
            let result = await self.searchService.exec(name: request)
            searched.removeAll()
            result.forEach{
                let hash = "\($0.description)"
                searched.append(hash)
                
                
            }
            
            
        }
    }
    
    
}
