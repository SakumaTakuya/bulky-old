//
//  EditWorkoutForm.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI

struct EditWorkoutForm: View {
    @ObservedObject var observable: EditWorkoutObservable
    var onAppend: (WorkoutEditData) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Menu")) {
                    SearchBar(
                        text: $observable.data.name,
                        results: observable.searched,
                        onSearch: observable.search
                    ) { value in
                        HStack {
                            Text(value)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Edit Workout")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    // NOTE: application will crash when using Button
                    Text("cancel")
                        .onTapGesture {
                            
                        }
                        .foregroundColor(.accentColor)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Text("append")
                        .onTapGesture {
                            onAppend(observable.data)
                        }
                        .foregroundColor(.accentColor)
                }
                
            }
        }
    }
}

#if DEBUG
struct EditWorkoutFormPreviewsView : View {
    @StateObject var observable: EditWorkoutObservable = EditWorkoutObservable()
    
    var body: some View {
        EditWorkoutForm(
            observable: observable
        ) { data in
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
