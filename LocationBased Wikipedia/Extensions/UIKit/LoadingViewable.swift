//
//  LoadingViewable.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/1/21.
//

import UIKit

protocol LoadingViewable: AnyObject {
    func animateActivityIndicator()
    func removeActivityIndicator()
}

extension UIView: LoadingViewable {
    
    func animateActivityIndicator() {
        
        let indicatorView = UIActivityIndicatorView()
        indicatorView.style = .large
        
        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        indicatorView.restorationIdentifier = "loadingView"
        
        indicatorView.startAnimating()
    }
    
    func removeActivityIndicator() {
        self.subviews.first(where: {$0.restorationIdentifier == "loadingView"})?.removeFromSuperview()
    }
}
