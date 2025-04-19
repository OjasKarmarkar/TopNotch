//
//  EventMonitor.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//
import SwiftUI

class EventMonitor {
    
    var notchController = NotchController.shared
    
    init() {
        
        let minX = NSScreen.main?.notchFrame?.minX ?? 0
        let minY = NSScreen.main?.notchFrame?.minY ?? 0
        let maxX = NSScreen.main?.notchFrame?.maxX ?? 0
        let maxY = NSScreen.main?.notchFrame?.maxY ?? 0
        
        NSEvent.addGlobalMonitorForEvents(matching: .mouseMoved) { event in
            let mouseX = event.locationInWindow.x;
            let mouseY = event.locationInWindow.y;
            
            if mouseX >= minX && mouseX <= maxX && minY<=mouseY && mouseY<=maxY {
                self.notchController.expandPanel();
            }
        }
    }
}
