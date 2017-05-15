//
//  AppDelegate.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/15/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else { fatalError("no window") }
        window.rootViewController = AppController()
        window.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
         try! FIRAuth.auth()?.signOut() //TODO: Remove, temporary logout until app function is in place
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        try! FIRAuth.auth()?.signOut() //TODO: Remove, temporary logout until app function is in place
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        try! FIRAuth.auth()?.signOut() //TODO: Remove, temporary logout until app function is in place
    }


}

