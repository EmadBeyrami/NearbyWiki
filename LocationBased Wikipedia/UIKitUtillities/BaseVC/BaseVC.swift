//
//  BaseVC.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 8/7/21.
//

import UIKit
class BaseVC: UIViewController {
    
    // MARK: - language callback handler
    var userChangedLanguageHandler: DataCompletion<SupportedLanguages> = { _ in }
    
    // MARK: - Language Action sheet
    lazy var changeLanguageAlertController: UIAlertController = {
        
        let alert = UIAlertController(title: LocalizedStrings.changeLang.value, message: nil, preferredStyle: .actionSheet)
        
        let englishLangAlert = UIAlertAction(title: SupportedLanguages.english.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.userChangedLanguageHandler(.english)
        }
        
        let finnishLangAlert = UIAlertAction(title: SupportedLanguages.finnish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.userChangedLanguageHandler(.finnish)
        }
        
        let spanishLangAlert = UIAlertAction(title: SupportedLanguages.spanish.text, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.userChangedLanguageHandler(.spanish)
        }
        
        let cancelAction = UIAlertAction(title: LocalizedStrings.cancel.value, style: .cancel)
        
        alert.addAction(englishLangAlert)
        alert.addAction(finnishLangAlert)
        alert.addAction(spanishLangAlert)
        alert.addAction(cancelAction)
        
        return alert
    }()
    
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
