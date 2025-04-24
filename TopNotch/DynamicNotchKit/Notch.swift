//
//  Notch.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//

import SwiftUI

struct NotchInfoPanelView: View {
    
    var notchController: NotchController
    
    var body: some View {
        
        if notchController.isExpanded{
            
            HStack(alignment: .center,spacing: 12) {
                Image(systemName: notchController.panelType.icon)
                    .foregroundStyle(.yellow)
                    .imageScale(.large)
                Spacer()
                Text(notchController.panelType.content(level: notchController.volume))
                        .font(.headline)
                        
                        .foregroundStyle(.white)
                    
                }
                            
            .padding()
            .background(.black)
            .cornerRadius(20)
        }else{
            
        }
    }
}

