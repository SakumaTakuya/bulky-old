//
//  EditWorkoutForm.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/03/19.
//

import Foundation
import SwiftUI
import Charts

struct EditWorkoutForm: View {
    @StateObject var observable: EditWorkoutObservable
    @State var isSelected : Bool = false
    @State var textField: String = ""
    @Environment(\.dismiss) var dismiss
    
    var onAppend: (WorkoutEditData) -> Void
    
    func searchContent(data : WorkoutEditData, scale : Int) -> some View {
        VStack(alignment: .leading) {
            Text(data.date.formatted())
                .font(.caption)
            HStack {
                Text(data.name)
                    .font(.headline)
                Spacer()
                Chart {
                    ForEach(
                        Array(data.sets.enumerated())
                        , id: \.element) { index, s in
                        BarMark(
                            x: .value("weight", s.weight),
                            y: .value("reps", "\(index)")
                        )
                    }
                }
                .chartXScale(domain: 0 ... scale)
//                .chartYScale(domain: 0 ... 200)

            }

        }
    }
    
    var body: some View {
        Form {
            Section(header: Text("Menu")) {
                VStack {
                    Button(action: {
                        isSelected = true
                    }) {
                        HStack {
                            Text(textField)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .buttonStyle(.borderless)
                    .accentColor(Color.primary)
                    .sheet(isPresented: $isSelected) {
                        Form {
                            let scale = observable.scale
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("test", text: $textField)
                                    .onTapGesture {
                                        isSelected = true
                                    }
                                    .onChange(of: textField, perform: { newText in
                                        observable.search(request: textField)
                                    })
                                Button("cancel") {
                                    isSelected = false
                                }
                            }
                            if !textField.isEmpty && isSelected {
                                let data = WorkoutEditData(
                                    name: textField
                                )
                                Button {
                                    observable.data = data
                                    textField = data.name
                                    isSelected = false
                                } label: {
                                    searchContent(data: data, scale: scale)
                                }
                            }
                            
                            if !$observable.searchResults.isEmpty && isSelected {
                                ForEach(observable.searchResults, id: \.self) { result in
                                    let data = WorkoutEditData(
                                        workout: result
                                    )
                                    
                                    Button {
                                        observable.data = data
                                        textField = data.name
                                        isSelected = false
                                    } label: {
                                        searchContent(data: data, scale: 120)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Section(header: Text("Workout Details")) {
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("append")
                    .onTapGesture {
                        onAppend(observable.data)
                        dismiss()
                    }
                    .foregroundColor(.accentColor)
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
