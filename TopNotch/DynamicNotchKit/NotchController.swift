//
//  NotchController.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//

import AppKit
import SwiftUI

class NotchController {
    static let shared = NotchController()

    private var panel: NSPanel?
    private var isVisible = false

    func showPanel() {
        print(isVisible)
        if(!isVisible){
            guard panel == nil else { return }

            // Create SwiftUI view
            let contentView = NSHostingView(rootView: NotchInfoPanelView())

            // Create NSPanel
            let newPanel = NSPanel(
                contentRect: NSRect(x: 0, y: 0, width: 240, height: 80),
                styleMask: [.borderless],
                backing: .buffered,
                defer: false
            )

            newPanel.contentView = contentView
            newPanel.level = .floating
            newPanel.hasShadow = true
            newPanel.isOpaque = false
            newPanel.backgroundColor = .clear
            newPanel.ignoresMouseEvents = false
            newPanel.level = .screenSaver
            newPanel.collectionBehavior = [.canJoinAllSpaces, .stationary]
            //newPanel.isFloatingPanel = true
            newPanel.hidesOnDeactivate = false

            // Position under notch
            if let notchFrame = NSScreen.main?.notchFrame {
                let panelWidth: CGFloat = 240
                let panelHeight: CGFloat = NSScreen.main?.notchFrame?.height ?? 80;

                    let xPosition = notchFrame.midX - panelWidth / 2
                    let yPosition = notchFrame.minY - panelHeight // Slight overlap/offset to "touch" notch
                
    
                
                    newPanel.setFrameOrigin(CGPoint(x: xPosition, y: yPosition))
            } else {
                print("No notchFrame detected.")
                // fallback
                newPanel.setFrameOrigin(CGPoint(x: 400, y: 400))
            }

            newPanel.orderFrontRegardless()
            
            self.panel = newPanel
            isVisible = true;
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                
                // animation for closing
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = 0.5
                    newPanel.animator().alphaValue = 0.0
                } completionHandler: {
                    newPanel.orderOut(nil)
                    self.panel = nil
                    self.isVisible = false
                }
                
            }
        }
       
    }

    func hidePanel() {
        panel?.close()
        panel = nil
        isVisible = false;
    }
}

