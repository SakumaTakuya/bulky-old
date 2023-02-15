//
//  BulkyApp.swift
//  Bulky
//
//  Created by Sakuma Takuya on 2023/02/15.
//

import SwiftUI

@main
struct BulkyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
