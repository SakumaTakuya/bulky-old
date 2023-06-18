//
//  ContentView.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
        }
        .padding(.all, 4.0)
    }
}

struct ContentView_Preview : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
