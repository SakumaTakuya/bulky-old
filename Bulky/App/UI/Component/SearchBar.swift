//
//  SearchBar.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation
import SwiftUI


struct SearchBar<Content : View>: View {
    @State var textField: String = ""
    @State var results: [String] = []
    @State var isSelected : Bool = false
    @Binding var text: String
    let onSearch : (String) -> [String]
    let content: (String) -> Content
    
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
                                results = onSearch(newText)
                            })
                        Button("cancel") {
                            isSelected = false
                        }
                        
                    }
                    if !textField.isEmpty && isSelected {
                        Button {
                            text = textField
                            isSelected = false
                        } label: {
                            content(textField)
                        }
                    }
                    
                    if !results.isEmpty && isSelected {
                        ForEach(results, id: \.self) { result in
                            Button {
                                text = result
                                isSelected = false
                            } label: {
                                content(result)
                            }
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct SearchBar_PreviewsView : View {
    @State var text : String = ""
    
    var body: some View {
        Form {
            Section(header: Text("menu")) {
                SearchBar(text: $text, onSearch: getResults) { value in
                    HStack {
                        Text(value.description)
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
    
    private func getResults(search : String) -> [String] {
        if (search.isEmpty) {
            return []
        }

        return [
            "\(search)...1",
            "\(search)...2",
            "\(search)...3",
            "\(search)...4",
            "\(search)...5",
        ]
    }
}


struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar_PreviewsView()
    }
}
#endif
