//
//  AppDelegate.swift
//  MacPawAssignment
//
//  Created by Саша Василенко on 12.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let navVC = UINavigationController()
        let builder = Builder()
        let router = Router(navigationController: navVC, builder: builder)
        router.mainViewController()
        window?.rootViewController = navVC
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        return true
    }
}

