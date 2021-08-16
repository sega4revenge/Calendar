//
//  AppDelegate.swift
//  Calendar
//
//  Created by Tô Tử Siêu on 16/08/2021.
//

import UIKit
import Bagel
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let shared: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()
    
    var rootViewController: RootViewController {
        return window?.rootViewController as! RootViewController
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController(screen: .home)
        window?.makeKeyAndVisible()
        
        setupBagel()
        
        return true
    }
    
    private func setupBagel() {
        guard Environment.current != .production else { return }
        Bagel.start()
    }
}

