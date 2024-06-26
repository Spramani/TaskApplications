//
//  Language.swift
//  LocalizationTask
//
//  Created by Shubham Ramani on 13/03/24.
//

import Foundation
import UIKit


extension Bundle {
    private static var bundle: Bundle!
    
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: "app_lang")
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else {
                   return
               }
        UserDefaults.standard.synchronize()
        self.bundle = Bundle.init(path: path)
        
    }
  
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}

