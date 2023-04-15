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

struct SearchBar<T: CustomStringConvertible>: View {
    @State var text: String = ""
    @State var results: [SearchResult<T>] = []
    @Binding var isSelected : Bool
    let onSearch : (String) -> [SearchResult<T>]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("test", text: $text)
                    .onTapGesture {
                        isSelected = true
                    }
                    .onChange(of: text, perform: { newText in
                        results = onSearch(newText)
                    })
                if (isSelected) {
                    Button("cancel") {
                        isSelected = false
                    }
                }
            }
            if !results.isEmpty && isSelected {
                ForEach(results) { result in
                     Button(result.description) {
                         text = result.description
                     }.buttonStyle(.borderless)
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
                SearchBar<String>(isSelected: $focus) { value in
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
                }
            }
            
            Section {
                Text("TEST")
                Text("TEST")
                Text("TEST")
                Text("TEST")
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
