//
//  Vibration.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/2/21.
//

import AVFoundation
import UIKit

// MARK: - Vibration Class
// Supports all type of haptic engine vibrations
enum Vibration {
    case error
    case success
    case warning
    
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    
    case peek
    case pop
    case nope
    
    case tryAgain
    case failed
    
    func vibrate() {

      switch self {
      case .error:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
      case .success:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
      case .warning:
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
      case .light:
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
      case .medium:
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
      case .heavy:
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
      case .selection:
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        
      case .oldSchool:
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
      case .peek:
        AudioServicesPlaySystemSound(1519)
      case .pop:
        AudioServicesPlaySystemSound(1520)
      case .nope:
        AudioServicesPlaySystemSound(1521)
        
      case .tryAgain:
        AudioServicesPlaySystemSound(1102)
      case .failed:
        AudioServicesPlaySystemSound(1107)
      }
    }

}
