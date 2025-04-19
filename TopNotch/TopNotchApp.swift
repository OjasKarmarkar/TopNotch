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
    let eventMonitor : EventMonitor
    let volumeObserver = VolumeListener()
    let notchController = NotchController.shared;
    
    init() {
        notchController.initPanel();
        eventMonitor = EventMonitor()
    }

    var body: some Scene {
        
        MenuBarExtra {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        } label : {
            Label("Top Notch", systemImage:"_gm")
        }
        
    }
    


}
