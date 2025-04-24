//
//  VolumeListener.swift
//  TopNotch
//
//  Created by Ojas on 19/04/25.
//


import CoreAudio
import CoreAudioTypes
import AVFoundation
import SwiftUI

class VolumeListener {
    
    var listenerBlock: AudioObjectPropertyListenerBlock?
    var notchController = NotchController.shared

    
    init() {

        startListening()
    }

    deinit {
        stopListening()
    }

    var outputDeviceID: AudioDeviceID {
        var defaultOutputDeviceID = AudioDeviceID(0)
        var size = UInt32(MemoryLayout<AudioDeviceID>.size)
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultOutputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )

        AudioObjectGetPropertyData(
            AudioObjectID(kAudioObjectSystemObject),
            &address,
            0,
            nil,
            &size,
            &defaultOutputDeviceID
        )

        return defaultOutputDeviceID
    }

    func startListening() {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: kAudioObjectPropertyElementMain
        )
        
        listenerBlock = { _, _ in
            Task { @MainActor in
                self.printCurrentVolume()
            }
            }
        
        if let block = listenerBlock {
            let status = AudioObjectAddPropertyListenerBlock(
                outputDeviceID,
                &address,
                nil,
                block
            )
            
            if status == noErr {
                print("Started listening for volume changes")
            } else {
                print("Error adding volume listener")
            }
        }
    }

    func stopListening() {
        guard let block = listenerBlock else { return }

        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: kAudioObjectPropertyElementMain
        )

        AudioObjectRemovePropertyListenerBlock(outputDeviceID, &address, nil, block)
    }

    @MainActor func printCurrentVolume() {
        var volume: Float32 = 0
        var size = UInt32(MemoryLayout.size(ofValue: volume))

        var address = AudioObjectPropertyAddress(
            mSelector: kAudioDevicePropertyVolumeScalar,
            mScope: kAudioDevicePropertyScopeOutput,
            mElement: kAudioObjectPropertyElementMain
        )

        let status = AudioObjectGetPropertyData(outputDeviceID, &address, 0, nil, &size, &volume)

        if status == noErr {
//            let notch = DynamicNotchInfo(
//                icon: Image(systemName: "figure"),
//                title: "\(volume)",
//                description: "Looks like a person"
//            )
//            notch.show(for:2);
            //notch.setContent(title: "\(volume)")
           // notch.show(for : 2);
            self.notchController.volume = volume;
            self.notchController.expandPanel(type: NotchContent.soundChange);
            print("Current Volume: \(volume)");
            //notch.hide();
        }
    }
}
