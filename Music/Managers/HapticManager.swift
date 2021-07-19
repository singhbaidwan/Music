//
//  HapticManagerViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit

final class HapticManager{
    static let shared = HapticManager()
    private init (){}
    public func vibrateForSelection(){
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    public func vibrate(for type:UINotificationFeedbackGenerator.FeedbackType)
    {
        DispatchQueue.main.async {
            let genertor = UINotificationFeedbackGenerator()
            genertor.prepare()
            genertor.notificationOccurred(type)
        }
    }
}
