//
//  WorkoutCollectionView.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct WorkoutCollectionView: View {
    @Environment(\.injected) var injected : Container
    
    @StateObject var observable: WorkoutCollectionViewObservable
    @State private var showingAddWorkout = false
    
    init(observable: WorkoutCollectionViewObservable) {
        self._observable = StateObject(wrappedValue: observable)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(observable.workouts, id: \.id) { workout in
                    NavigationLink(destination: WorkoutDetailView()) {
                        WorkoutCell(workout)
                    }
                }
                .onDelete(perform: observable.delete)
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems(trailing: addButton)
        }
        .sheet(isPresented: $showingAddWorkout) {
            NavigationView {
                EditWorkoutForm(
                    observable: injected.createEditWorkoutObservable()
                ) { workout in
                    observable.update(data: workout)
                }
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
struct WorkoutCollectionViewPreviewsView : View {
    @Environment(\.injected) var injected : Container
    
    var body: some View {
        WorkoutCollectionView(
            observable: injected.createWorkoutCollectionViewObservable()
        )
    }
}

struct WorkoutCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCollectionViewPreviewsView()
    }
}
#endif
