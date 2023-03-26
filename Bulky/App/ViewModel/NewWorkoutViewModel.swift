//
//  NewWorkoutViewModel.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation

final class NewWorkoutViewModel : ObservableObject {
    @Published var newWorkoutUiState : NewWorkoutUiState = NewWorkoutUiState.default
}
