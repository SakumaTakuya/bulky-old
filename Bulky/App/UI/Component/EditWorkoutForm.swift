//
//  EditWorkoutForm.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct EditWorkoutForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservableState(\.test) var observable: EditWorkoutObservable?
    var onAppend: (WorkoutEditData) -> Void
    
    init(
        observable: EditWorkoutObservable,
        onAppend: @escaping (WorkoutEditData
    ) -> Void) {
//        self._observable = StateObject(wrappedValue: observable)
        self.onAppend = onAppend
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Menu")) {
                    SearchForm(
                        searchResults: observable.searched,
                        onSearch: observable.search,
                        onSelect: observable.select
                    ) { value in
                        HStack {
                            switch value {
                            case let .New(request):
                                Text(request)
                            case let .Searched(workout):
                                WorkoutCell(workout)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                Section(header: Text("Workout Details")) {
                    ForEach(observable.data.sets, id: \.self) { exercise in
                        let text = "\(exercise.weight)"
                        Text(text)
                    }
                    
                    Button("add") {
                        observable.addExercise()
                    }

                    DatePicker(
                        "Date",
                        selection: $observable.data.date,
                        displayedComponents: [.date]
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("append") {
                        dismiss()
                        onAppend(observable.data)
                    }
                }
                
            }
        }
    }
}

#if DEBUG
class Test : ObservableObject {
    let service : SearchWorkHistoryService
    
    init(service: SearchWorkHistoryService) {
        self.service = service
    }
}

struct EditWorkoutFormPreviewsView : View {
    @Environment(\.injected) var injected : Container
    
    var body: some View {
        EditWorkoutForm(
            observable: injected.createEditWorkoutObservable()) { data in
                print(data)
            }
    }
}


struct EditWorkoutForm_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkoutFormPreviewsView()
    }
}
#endif
