//
//  AppDelegate.swift
//  LocalizationTask
//
//  Created by Shubham Ramani on 13/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func appDelegate() -> AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("could not get app delegate ")
        }
        return delegate
     }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setHome()
       
        return true
    }
    func setHome(){
        let vc = HomeVC()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
    
    func ChangeLayout(){
        var languageCode = ""
        if let value = UserDefaults.standard.string(forKey: "app_lang") {
            languageCode = value
        }else{
            languageCode = ""
        }
        if(languageCode == "ar"){
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }

}
