//
//  WorkoutRepository.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/05.
//

import Foundation
import Combine

protocol WorkoutRepository {
    func search(name : String) async -> [Workout]
    func store(item : Workout) async -> Void
}
