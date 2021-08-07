//
//  BaseVC.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/7/21.
//

import UIKit
class BaseVC: UIViewController {
    
    // MARK: - public funcs
    // we can add action call back but in our case is unnessecary
    func showAlert(title: String = LocalizedStrings.error.value,
                   message: String = "",
                   actionBtnTitle: String = LocalizedStrings.ok.value) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionBtnTitle, style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}
