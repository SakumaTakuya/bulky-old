//
//  WorkoutCollectionView.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct WorkoutCollectionView: View {

    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts, id: \.id) { workout in
                    NavigationLink(destination: WorkoutDetailView()) {
                        Text(workout.menu.name)
                    }
                }
                .onDelete(perform: deleteWorkout)
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $showingAddWorkout) {
            NavigationView {
                EditWorkoutForm(
                    observable: EditWorkoutObservable()
                ) { workout in
                    showingAddWorkout = false
                    Task {
                        await editService.exec(data: workout)
                    }
                }
            }
        }
    }
    
    @State private var showingAddWorkout = false
    
    private var addButton: some View {
        Button(action: { showingAddWorkout = true }) {
            Image(systemName: "plus")
        }
    }
    
    private func deleteWorkout(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
}

#if DEBUG
struct EditWorkoutStubService : EditWorkoutService {
    var workouts: [Workout] = []
    func exec(data : WorkoutEditData) async {
        
    }
}

struct WorkoutCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCollectionView(
            editService: <#T##EditWorkoutService#>
        )
    }
}
#endif
