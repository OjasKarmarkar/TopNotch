//
//  TopNotchApp.swift
//  TopNotch
//
//  Created by Ojas on 18/04/25.
//

import SwiftUI

@main
struct TopNotchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
