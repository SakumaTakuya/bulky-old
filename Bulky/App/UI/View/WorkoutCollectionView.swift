//
//  WorkoutCollectionView.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct WorkoutCollectionView: View {
    @StateObject var observable: WorkoutCollectionViewObservable
    @State private var showingAddWorkout = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(observable.workouts, id: \.id) { workout in
                    NavigationLink(destination: WorkoutDetailView()) {
                        Text(workout.menu.name)
                    }
                }
                .onDelete(perform: observable.delete)
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $showingAddWorkout) {
            NavigationView {
//                EditWorkoutForm(
//                    observable: EditWorkoutObservable()
//                ) { workout in
//                    showingAddWorkout = false
//                    observable.update(data: workout)
//                }
            }
        }
    }
    
    private var addButton: some View {
        Button(action: { showingAddWorkout = true }) {
            Image(systemName: "plus")
        }
    }
}

#if DEBUG
struct WorkoutCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCollectionView(
            observable: WorkoutCollectionViewObservable(
                collectionService: CollectionWorkoutServicePreview(),
                editService: EditWorkoutServicePreview()
            )
        )
    }
}
#endif
