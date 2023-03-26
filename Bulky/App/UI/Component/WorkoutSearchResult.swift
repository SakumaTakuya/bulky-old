//
//  WorkoutSearchResult.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/18.
//

import Foundation
import SwiftUI

struct OnTapOutsideView: View {
    enum Field: Hashable {
        case title
        case message
    }

    @State private var titleText = ""
    @State private var messageText = ""
    @FocusState private var focusedField: Field?

    var body: some View {

        VStack {
            TextField("タイトル", text: $titleText)
            TextField("メッセージ", text: $messageText)
            if focusedField != nil {
                List {
                    Button("test") {
                        titleText = "test"
                        focusedField = nil
                    }
                    Button("test") {
                        focusedField = nil
                    }
                    Button("test") {
                        focusedField = nil
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
        .contentShape(RoundedRectangle(cornerRadius: 10))
        .onLongPressGesture {
            focusedField = nil
        }
    }
}

#if DEBUG
struct OnTapOutsideView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("test1")
            OnTapOutsideView()
            Text("test")
        }
    }
}
#endif
