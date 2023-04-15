//
//  SearchBar.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation
import SwiftUI

struct SearchResult<T : CustomStringConvertible> : Identifiable, CustomStringConvertible {
    let id = UUID()
    let data : T
    var description: String { return data.description }
    
    init(_ data: T) {
        self.data = data
    }
}


struct SearchBar<T: CustomStringConvertible, Content : View>: View {
    @State var text: String = ""
    @State var results: [SearchResult<T>] = []
    @Binding var isSelected : Bool
    let onSearch : (String) -> [SearchResult<T>]
    let content: ([SearchResult<T>]) -> Content
    
    var body: some View {
        VStack {
            Button(action: {
                isSelected = true
            }) {
                HStack {
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .buttonStyle(.borderless)
            .accentColor(Color.primary)
            .sheet(isPresented: $isSelected) {
                Form {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("test", text: $text)
                            .onTapGesture {
                                isSelected = true
                            }
                            .onChange(of: text, perform: { newText in
                                results = onSearch(newText)
                            })
                        Button("cancel") {
                            isSelected = false
                        }

                    }
                    if !results.isEmpty && isSelected {
                        ForEach(results) { result in
                            Button(result.description) {
                                text = result.description
                                isSelected = false
                            }.buttonStyle(.borderless)
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
struct SearchBarView : View {
    @State var focus : Bool = false
    
    var body: some View {
        Form {
            Section {
                SearchBar<String, Text>(isSelected: $focus) { value in
                    if value.isEmpty {
                        return []
                    }
                    
                    return [
                        SearchResult("\(value)...1"),
                        SearchResult("\(value)...2"),
                        SearchResult("\(value)...3"),
                        SearchResult("\(value)...4"),
                        SearchResult("\(value)...5"),
                    ]
                } content: { value in
                    Text(value.description)
                }
            } header: {
                Text("menu")
            }
            
            Section {
                Text("TEST")
                Text("TEST")
                Text("TEST")
                Text("TEST")
            } header: {
                Text("menu")
            }
            
        }

    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBarView()
    }
}
#endif
