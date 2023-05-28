//
//  SearchForm.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/05/28.
//

import Foundation
import SwiftUI

enum Selection<Data> {
    case Searched(Data)
    case New(String)
}

struct SearchForm<Data : Hashable, Content : View>: View {
    @State var textField: String = ""
    @State var isSelected : Bool = false
    @Binding var selection: Selection<Data>
    let searchResults: [Data]
    let onSearch : (String) -> Void
    let content: (Selection<Data>) -> Content
    
    var body: some View {
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
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("test", text: $textField)
                            .onTapGesture {
                                isSelected = true
                            }
                            .onChange(of: textField, perform: { newText in
                                onSearch(newText)
                            })
                        Button("cancel") {
                            isSelected = false
                        }
                        
                    }
                    if !textField.isEmpty && isSelected {
                        let new = Selection<Data>.New(textField)
                        Button {
                            selection = new
                            isSelected = false
                        } label: {
                            content(new)
                        }
                    }
                    
                    if !searchResults.isEmpty && isSelected {
                        ForEach(searchResults, id: \.self) { result in
                            let searched = Selection<Data>.Searched(result)
                            
                            Button {
                                selection = searched
                                isSelected = false
                            } label: {
                                content(searched)
                            }
                        }
                    }
                }
            }
        }
    }
}


#if DEBUG
struct SearchForm_PreviewsView : View {
    @State var selection : Selection<String> = .New("")
    @State var searched: [String] = []
    
    var body: some View {
        Form {
            Section(header: Text("menu")) {
                SearchForm(
                    selection: $selection,
                    searchResults: searched,
                    onSearch: getResults
                ) { value in
                    HStack {
                        switch value {
                        case let .Searched(data):
                            Text(data.description)
                        case let .New(name):
                            Text(name)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }

            Section(header: Text("menu")) {
                Text("TEST")
                Text("TEST")
                Text("TEST")
                Text("TEST")
            }
        }
    }
    
    private func getResults(search : String) {
        if (search.isEmpty) {
            searched = []
            return
        }

        searched = [
            "\(search)...1",
            "\(search)...2",
            "\(search)...3",
            "\(search)...4",
            "\(search)...5",
        ]
    }
}


struct SearchForm_Previews: PreviewProvider {
    static var previews: some View {
        SearchForm_PreviewsView()
    }
}
#endif
