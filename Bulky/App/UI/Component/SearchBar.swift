//
//  SearchBar.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @State var text: String = ""
    @State var results: [String] = []
    @Binding var isSelected : Bool
    let onSearch : (String) -> [String]
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("test", text: $text)
                        .onTapGesture {
                            isSelected = true
                        }
                    if (isSelected) {
                        Button("cancel") {
                            isSelected = false
                        }
                    }
                }
                if (!results.isEmpty && isSelected) {
                    List(results, id: \.self) { result in
                        Button(result) {
                            text = result
                            isSelected = false
                        }
                    }
                }
            }
            .onChange(of: text, perform: { newText in
                results = onSearch(newText)
            })
        }
    }
}

#if DEBUG
struct SearchBarView : View {
    @State var focus : Bool = false
    
    var body: some View {
        SearchBar(isSelected: $focus) { value in
            if (value.isEmpty) {
                return []
            }
            
            return [
                "\(value)...1",
                "\(value)...2",
                "\(value)...3",
                "\(value)...4",
            ]
        }.onTapGesture {
            focus = false
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBarView()
    }
}
#endif
