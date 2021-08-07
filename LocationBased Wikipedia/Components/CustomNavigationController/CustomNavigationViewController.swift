//
//  CustomNavigationViewController.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/2/21.
//

import UIKit
import FittedSheets

class CustomNavigationController: UINavigationController {
    
    func modalPresentationVC(newController: UIViewController, sizes: [SheetSize], willDismiss: Completion? = nil, completion: Completion? = nil) {
        
        guard let presentationViewController = self.visibleViewController else { return }
        
        let options = SheetOptions(
            // Extends the background behind the pull bar or not
            shouldExtendBackground: true,

            // Shrinks the presenting view controller, similar to the native modal
            shrinkPresentingViewController: false
        )
        
        let sheetController = SheetViewController(controller: newController, sizes: sizes, options: options)
        sheetController.gripColor = .gray
        sheetController.gripSize = CGSize(width: 60.0, height: 5.0)
        sheetController.autoAdjustToKeyboard = true
        sheetController.allowPullingPastMaxHeight = false
        sheetController.cornerRadius = 30.0
        sheetController.overlayColor = .clear

        sheetController.dismissOnPull = true
        sheetController.dismissOnOverlayTap = true
        
        sheetController.didDismiss = { _ in
            willDismiss?()
        }
        
        Vibration.heavy.vibrate()
        
        presentationViewController.present(sheetController, animated: true, completion: {
            completion?()
        })
    }
    
}
