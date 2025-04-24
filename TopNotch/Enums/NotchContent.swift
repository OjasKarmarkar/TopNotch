//
//  NotchContent.swift
//  TopNotch
//
//  Created by Ojas on 25/04/25.
//

enum NotchContent {
    case mouseHover;
    case soundChange;
}

extension NotchContent {
    
    var icon : String {
        switch self {
        case .mouseHover:
        return "bolt.circle.fill"
        case .soundChange:
        return "speaker"
        }
    }
    
    func content(level : Float?) -> String{
        switch self {
        case .mouseHover:
            return "Bonjour :)"
        case .soundChange:
            return "\(level ?? 0)"
        }
    }
    
}
