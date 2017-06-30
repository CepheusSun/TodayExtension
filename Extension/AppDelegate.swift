//
//  AppDelegate.swift
//  Extension
//
//  Created by sunny on 2017/6/30.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let prefix = "sunny://"
        if url.absoluteString.hasPrefix(prefix) {
            let a = UIAlertController(title: url.absoluteString, message: nil, preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            self.window?.rootViewController?.present(a, animated: true, completion: nil)
            return true
        }
        return false
        
    }
}

