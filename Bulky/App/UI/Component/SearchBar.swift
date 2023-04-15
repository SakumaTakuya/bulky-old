//
//  SearchBar.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation
import SwiftUI


struct SearchBar<
    T: Hashable & CustomStringConvertible,
    Content : View>: View {
    @State var text: String = ""
    @State var results: [T] = []
    @Binding var isSelected : Bool
    let onSearch : (String) -> [T]
    let content: (T) -> Content
    
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
                        ForEach(results, id: \.self) { result in
                            Button {
                                text = result.description
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
struct SearchBarView : View {
    @State var focus : Bool = false
    
    var body: some View {
        Form {
            Section {
                SearchBar(isSelected: $focus, onSearch: getResults) { value in
                    HStack {
                        Text(value.description)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
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
        SearchBarView()
    }
}
#endif
