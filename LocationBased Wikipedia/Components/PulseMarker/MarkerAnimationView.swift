//
//  MarkerAnimationView.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import Foundation
import UIKit

class MarkerAnimationView: ViewWithPersistentAnimations, ViewConnectable {
    
    // MARK: - IBOutlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    
    // MARK: - Properties
    private var pulseAnimation: PulseAnimation?
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func initialize() {
        connectView()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        containerView.backgroundColor = .clear
        pulsate()
    }
    
    // MARK: - Animation
    private func pulsate() {
        containerView.layoutIfNeeded()
        self.pulseAnimation = PulseAnimation(numberOfPulse: Float.infinity, radius: containerView.bounds.size.height/2, postion: imageView.center, delay: 1.0)
        self.pulseAnimation!.animationDuration = 2.0
        self.pulseAnimation!.backgroundColor = UIColor.blue.cgColor
        containerView.layer.insertSublayer(self.pulseAnimation!, below: imageView.layer)
    }
    
}
