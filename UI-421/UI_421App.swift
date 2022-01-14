//
//  UI_421App.swift
//  UI-421
//
//  Created by nyannyan0328 on 2022/01/14.
//

import SwiftUI

@main
struct UI_421App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
