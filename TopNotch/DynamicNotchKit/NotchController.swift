//
//  NotchController.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//

// Keep the panel always there - hidden under the notch, and then expand / collapse when needed.

import AppKit
import SwiftUI

@Observable
class NotchController {
    static let shared = NotchController()
    var isExpanded:Bool = false
    private var newPanel: NSPanel!
    final var notchSize = NSRect(x: 0, y: 0, width: NSScreen.main?.notchFrame?.width ?? 240, height: NSScreen.main?.notchFrame?.height ?? 80)
    let expandedSize = CGSize(width: 400, height: 160)
    let collapsedSize = CGSize(width: 1, height: 1)

    func frame(for size: CGSize, from notch: NSRect) -> NSRect {
        let x = notch.midX - size.width / 2
        let y = notch.maxY - size.height + 15
        print(x,y)
        return NSRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    private init () {
        
    }

    
    func animatePanel() {
        let targetSize = isExpanded ? expandedSize : collapsedSize
        let targetFrame = frame(for: targetSize, from: NSScreen.main?.notchFrame ?? .zero)

        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.45
            context.allowsImplicitAnimation = true
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            newPanel.animator().setFrame(targetFrame, display: true)
        }
    }

    func expandPanel() {
        if(!isExpanded){
            isExpanded.toggle();
            // Position under notch
            animatePanel()
            
            // Auto Hide
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.isExpanded.toggle();
                self.animatePanel();
            }
            
            
            
        }
       
    }
    
    func initPanel () {
        let contentView = NSHostingView(rootView: NotchInfoPanelView(notchController: Self.shared))
        
         newPanel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: collapsedSize.width, height: collapsedSize.height) ,
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
        newPanel.hidesOnDeactivate = false
        

        if let notchFrame = NSScreen.main?.notchFrame {
                let xPosition = notchFrame.midX
                let yPosition = notchFrame.midY
            // Slight overlap/offset to "touch" notch
            newPanel.setFrameOrigin(CGPoint(x: xPosition, y: yPosition))

            
        } else {
            print("No notchFrame detected.")
            // fallback
            newPanel.setFrameOrigin(CGPoint(x: 400, y: 400))
        }

        newPanel.orderFrontRegardless()
    }

    func hidePanel() {
        //newPanel?.close()
        isExpanded = false;
        animatePanel()
    }
}

