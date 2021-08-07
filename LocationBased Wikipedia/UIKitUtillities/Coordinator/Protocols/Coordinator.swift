//
//  Coordinator.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation
import UIKit
import FittedSheets

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: CustomNavigationController { get set }
    func navigateTo(deepLink: DeepLink)
    func start(animated: Bool)
    func finish()
}

extension Coordinator {
    
    func start() {
        start(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func modalPresentationViewController(newController: UIViewController, sizes: [SheetSize], willDismiss: Completion? = nil, completion: Completion? = nil) {
        navigationController.modalPresentationVC(newController: newController, sizes: sizes, willDismiss: willDismiss, completion: completion)
    }
    
    func navigateTo(deepLink: DeepLink) { }
    
    func finish() { }
}
