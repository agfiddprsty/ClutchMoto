//
//  PlaySound.swift
//  ClutchMoto
//
//  Created by Agfid Prasetyo on 20/04/23.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            if #available(iOS 16.0, *) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            } else {
                // Fallback on earlier versions
            }
            audioPlayer?.play()
            audioPlayer?.numberOfLoops = -1
        } catch {
            print("error")
        }
    }
}

func stopSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            if #available(iOS 16.0, *) {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
            } else {
                // Fallback on earlier versions
            }
            audioPlayer?.stop()
//            audioPlayer?.numberOfLoops = -1
        } catch {
            print("error")
        }
    }
}
