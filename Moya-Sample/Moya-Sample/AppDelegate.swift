//
//  AppDelegate.swift
//  Moya-Sample
//
//  Created by 木元健太郎 on 2022/03/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        return true
    }


}

