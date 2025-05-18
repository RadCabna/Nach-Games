//
//  SoundManager.swift
//  Nach Games
//
//  Created by Алкександр Степанов on 14.05.2025.
//

import Foundation
import AVFoundation
import SwiftUI

class SoundManager {
    @AppStorage("musicVolume") var musicVolume = 0.5 {
        didSet {
            updateMusicVolume()
        }
    }
    @AppStorage("soundVolume") var soundVolume = 0.5 {
        didSet {
            updateSoundVolume()
        }
    }
    
    static let instance = SoundManager()
    private let audioEngine = AVAudioEngine()
    private var audioPlayers: [AVAudioPlayerNode] = []
    private var audioTypes: [AVAudioPlayerNode: String] = [:]
    
    func preloadMusic(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else { return }
        
        do {
            let audioFile = try AVAudioFile(forReading: url)
            let audioPlayer = AVAudioPlayerNode()
            audioEngine.attach(audioPlayer)
            audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
            audioPlayer.scheduleFile(audioFile, at: nil, completionHandler: nil)
            audioPlayers.append(audioPlayer)
            audioTypes[audioPlayer] = "music"
        } catch let error {
            print("Sound not found! \(error.localizedDescription)")
        }
    }
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else { return }
        
        do {
            let audioFile = try AVAudioFile(forReading: url)
            let audioPlayer = AVAudioPlayerNode()
            audioPlayer.volume = Float(0.5 + soundVolume)
            audioEngine.attach(audioPlayer)
            audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
            try audioEngine.start()
            audioPlayer.scheduleFile(audioFile, at: nil, completionHandler: nil)
            audioPlayer.play()
            audioPlayers.append(audioPlayer)
            audioTypes[audioPlayer] = "sound"
        } catch let error {
            print("Sound not found! \(error.localizedDescription)")
        }
    }

    func loopSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else { return }
        
        do {
            let audioFile = try AVAudioFile(forReading: url)
            let audioPlayer = AVAudioPlayerNode()
            audioPlayer.volume = Float(0.5 + musicVolume)
            audioEngine.attach(audioPlayer)
            audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: audioFile.processingFormat)
            try audioEngine.start()
            audioPlayer.scheduleFile(audioFile, at: nil, completionHandler: nil)
            audioPlayer.play()
            audioPlayers.append(audioPlayer)
            audioTypes[audioPlayer] = "music"
        } catch let error {
            print("Sound not found! \(error.localizedDescription)")
        }
    }
    
     func updateMusicVolume() {
        let volume = Float(0.5 + musicVolume) / 2
        for player in audioPlayers {
            if let type = audioTypes[player], type == "music" {
                player.volume = volume
            }
        }
    }
    
    private func updateSoundVolume() {
        let volume = Float(0.5 + soundVolume) / 2
        for player in audioPlayers {
            if let type = audioTypes[player], type == "sound" {
                player.volume = volume
            }
        }
    }
    
    func stopAllSounds() {
        for player in audioPlayers {
            player.stop()
        }
        audioPlayers.removeAll()
        audioTypes.removeAll()
    }
}






