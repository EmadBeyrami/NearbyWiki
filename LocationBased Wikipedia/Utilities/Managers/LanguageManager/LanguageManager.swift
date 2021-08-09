//
//  LanguageManager.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import Foundation
import UIKit

enum SupportedLanguages: Int, CaseIterable {
    case english
    case spanish
    case finnish
    
    var languageDirection: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .spanish:
            return .ltr
        case .finnish:
            return .ltr
        }
    }
}

@objc enum LanguageDirection: Int {
    case rtl
    case ltr
}

protocol LanguageManagerProtocol {
    var currentLanguage: SupportedLanguages { get set }
    var allSupportedLanguages: [SupportedLanguages] { get }
}

class LanguageManager: LanguageManagerProtocol {
    // MARK: - Properties
    static let shared: LanguageManager = LanguageManager()
    
    var allSupportedLanguages: [SupportedLanguages] = SupportedLanguages.allCases
    var currentLanguage: SupportedLanguages {
        get {
            let identifier = UserDefaultsConfig.currentLanguage
            return SupportedLanguages(identifier: identifier)
        }
        set {
            UserDefaultsConfig.currentLanguage = newValue.identifier
            UIView.appearance().semanticContentAttribute = newValue.direction.semantic
            Bundle.setLanguage(newValue.identifier)
        }
    }
    
    var languagecalendar: Calendar {
        let locale = Locale(identifier: currentLanguage.locale)
        return locale.calendar
    }
    // MARK: - Methods
    private init() {}
    
    class func isAValidLanguageIdentifier(_ identifier: String) -> Bool {
        for language in shared.allSupportedLanguages where language.identifier == identifier {
            return true
        }
        return false
    }
}

extension SupportedLanguages {
    var text: String {
        switch self {
        case .english:
            return "English"
        case .finnish:
            return "Suomi"
        case .spanish:
            return "Spanish"
        }
    }
    
    var identifier: String {
        switch self {
        case .english:
            return "en-US"
        case .finnish:
            return "fi"
        case .spanish:
            return "es"
        }
    }
    
    var direction: LanguageDirection {
        switch self {
        case .english:
            return .ltr
        case .finnish:
            return .ltr
        case .spanish:
            return .ltr
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .finnish:
            return .left
        case .spanish:
            return .left
        }
    }
    
    var oppositeTextAlignment: NSTextAlignment {
        switch self {
        case .english:
            return .left
        case .finnish:
            return .left
        case .spanish:
            return .left
        }
    }
    
    var locale: String {
        switch self {
        case .english:
            return "en"
        case .finnish:
            return "fi"
        case .spanish:
            return "es"
        }
    }
    
    init(identifier: String?) {
        switch identifier ?? "en-US" {
        case "en-US":
            self = .english
        case "fi":
            self = .finnish
        case "es":
            self = .spanish
        default:
            self = .english
        }
    }
}

extension LanguageDirection {
    var semantic: UISemanticContentAttribute {
        switch self {
        case .ltr:
            return .forceLeftToRight
        case .rtl:
            return .forceRightToLeft
        }
    }
}
