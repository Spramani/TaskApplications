//
//  AppDelegate.swift
//  DrawPicture
//
//  Created by Shubham Ramani on 11/03/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    func applicationDidEnterBackground(_ application: UIApplication) {
           // Called when the app enters the background.
           // Use this method to release shared resources, save user data, invalidate timers, and store enough app state information to restore your app to its current state in case it is terminated later.
           // If your app supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
           
           // Perform actions specific to when the app enters the background mode
           print("App entered background")
       }
}

