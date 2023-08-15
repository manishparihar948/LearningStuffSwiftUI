//
//  HapticsAndVibrationBootCamp.swift
//  LearningSwiftUI
//
//  Created by Manish Parihar on 15.08.23.
//

import SwiftUI

class HapticManager {
    static let instance = HapticManager() // Singleton Classs
    
    func notification(type:UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style:UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsAndVibrationBootCamp: View {
    var body: some View {
        VStack(spacing:20) {
            Button("Success") {HapticManager.instance.notification(type: .success)}
            Button("Warning") {HapticManager.instance.notification(type: .warning)}
            Button("Error") {HapticManager.instance.notification(type: .error)}
            Divider()
            
            Button("Soft") {HapticManager.instance.impact(style: .soft)}
            Button("Light") {HapticManager.instance.impact(style: .light)}
            Button("Medium") {HapticManager.instance.impact(style: .medium)}
            Button("Heavy") {HapticManager.instance.impact(style: .heavy)}
            Button("Rigid") {HapticManager.instance.impact(style: .rigid)}
        }
    }
}

struct HapticsAndVibrationBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        HapticsAndVibrationBootCamp()
    }
}
