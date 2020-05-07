//  HapticFeedbackGenerator.swift
//  iPhone
//
//  Created by Darko Dujmovic on 20/02/2018.
//

import UIKit
class HapticFeedbackGenerator{
    
    static let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
    static let impactFeedbackGenerator = UIImpactFeedbackGenerator()
    
    static func generateHapticFeedbackWarning(){
        notificationFeedbackGenerator.notificationOccurred(.warning)
    }
    
    static func generateHapticFeedbackSuccess(){
        notificationFeedbackGenerator.notificationOccurred(.success)
    }
    
    static func generateHapticFeedbackError(){
        notificationFeedbackGenerator.notificationOccurred(.error)
    }
    
    static func generateHapticFeedbackHeavy(){
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactFeedbackGenerator.impactOccurred()
    }
    
    static func generateHapticFeedbackLight(){
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        impactFeedbackGenerator.impactOccurred()
    }
    
}
