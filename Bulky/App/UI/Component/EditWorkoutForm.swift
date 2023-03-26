//
//  EditWorkoutForm.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct EditWorkoutForm: View {
    @State var observable : WorkoutEditData = WorkoutEditData()
    @StateObject var observable: EditWorkoutObservable
    var onAppend: (WorkoutEditData) -> Void
        
    var body: some View {
        Form {
            Section(header: Text("Workout Details")) {
                TextField(
                    "Workout Name",
                    text: $observable.data.name
                )
                DatePicker(
                    "Date",
                    selection: $observable.data.date,
                    displayedComponents: [.date]
                )
            }
            Section {
                Button("Add") {
                    onAppend(observable.data)
                }
            }
        }
    }
}

#if DEBUG
struct EditWorkoutForm_Previews: PreviewProvider {
    static var previews: some View {
        EditWorkoutForm(
            observable: EditWorkoutObservable()
        ) { data in
            print(data)
        }
    }
}
#endif
