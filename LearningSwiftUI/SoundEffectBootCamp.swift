//
//  SoundEffectBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 15.08.23.
//

import SwiftUI
import AVKit

// When things changes in this class
// We need View to update automatically,
// thatswhy we make Observable class

class SoundManager {

    // Generic Singleton class to use in entire app thaty we did not use Observable class
    static let instance = SoundManager() // Singleton Class
    
    var player: AVAudioPlayer?
    
    enum SoundOption : String {
        case tada
        case badum
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}



struct SoundEffectBootCamp: View {
    
    var body: some View {
        VStack(spacing:40) {
            
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .badum)
            }
            
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .tada)
            }
        }
    }
}

struct SoundEffectBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectBootCamp()
    }
}
