//
//  Test.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/04/14.
//

import Foundation
import SwiftUI

struct Search : View {
    @State var text: String = ""
    @Binding var isSelected : Bool
    let onSearch : (String) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("test", text: $text)
                .onTapGesture {
                    withAnimation {
                        isSelected = true
                    }
                }
                .onChange(of: text, perform: onSearch)
            Button("cancel") {
                withAnimation {
                    isSelected = false
                }
            }

        }
    }
}

#if DEBUG
struct SearchPreviewView: View {
    @State var focus : Bool = false
    @State var results: [String] = []
    
    var body: some View {
        Form {
            Search(isSelected: $focus) { value in
                if value.isEmpty {
                    results = []
                }
                
                results = [
                    "\(value)...1",
                    "\(value)...2",
                    "\(value)...3",
                    "\(value)...4",
                    "\(value)...5",
                ]
            }
            if focus {
                List (results, id: \.self) { result in
                    Button(result) {
                        withAnimation {
                            focus = false
                        }
                    }
                }.transition(.opacity)
            }
            
            List {
                Text("Test")
                Text("AAA")
                Text("Test")
                Text("Test")
                Text("Test")
                Text("Test")
                Text("Test")
                Text("AAA")
            }.transition(.opacity)
            
        }
    }
}

struct Search_Previews: PreviewProvider {

    static var previews: some View {
        SearchPreviewView()
    }
}
#endif
