////
////  SearchBar.swift
////  Bulky
////
////  Created by Sakuma Takuya on 2023/02/18.
////
//
//import Foundation
//import SwiftUI
//
//
//struct SearchBar<Content : View>: View {
//    @State var textField: String = ""
//    @State var results: [String] = []
//    @State var isSelected : Bool = false
//    @Binding var text: String
//    let onSearch : (String) -> [String]
//    let content: (String) -> Content
//    
//    var body: some View {
//    }
//}
//
//#if DEBUG
//struct SearchBar_PreviewsView : View {
//    @State var text : String = ""
//    
//    var body: some View {
//        Form {
//            Section(header: Text("menu")) {
//                SearchBar(text: $text, onSearch: getResults) { value in
//                    HStack {
//                        Text(value.description)
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                    }
//                }
//            }
//
//            Section(header: Text("menu")) {
//                Text("TEST")
//                Text("TEST")
//                Text("TEST")
//                Text("TEST")
//            }
//        }
//    }
//    
//    private func getResults(search : String) -> [String] {
//        if (search.isEmpty) {
//            return []
//        }
//
//        return [
//            "\(search)...1",
//            "\(search)...2",
//            "\(search)...3",
//            "\(search)...4",
//            "\(search)...5",
//        ]
//    }
//}
//
//
//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar_PreviewsView()
//    }
//}
//#endif
