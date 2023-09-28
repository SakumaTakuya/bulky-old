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
    
    var body: some View {
        NavigationStack {
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
    }
    
    private var addButton: some View {
        NavigationLink(destination: {
            EditWorkoutForm(
                observable: EditWorkoutObservable()
            ) { workout in
                observable.update(data: workout)
            }
        }) {
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
