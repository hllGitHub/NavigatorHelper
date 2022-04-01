//
//  AppDelegate.swift
//  NavigatorHelper
//
//  Created by hlltd on 03/31/2022.
//  Copyright (c) 2022 hlltd. All rights reserved.
//

import UIKit
import NavigatorHelper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    setupNavigatorHelperConfig()
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    NavigatorHelper.shared.dispatchPendingURLIfHave()
  }
  
  func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
    return handleUserActivity(userActivity)
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    handleNotification(userInfo)
  }
}

extension AppDelegate {
  func handleUserActivity(_ userActivity: NSUserActivity) -> Bool {
    guard let url = userActivity.webpageURL,
          userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
      print("Invalid url form source application.")
      return false
    }
    
    return NavigatorHelper.shared.handleEntry(with: url)
  }
  
  func handleNotification(_ userInfo: [AnyHashable : Any]) {
    guard
      let link = userInfo["link"] as? String,
      let linkURL = URL(string: link) else {
      print("Invalid url in notification.")
      return
    }
    
    NavigatorHelper.shared.handleNotificationLink(linkURL)
  }
  
  func setupNavigatorHelperConfig() {
    NavigatorTool.requirement = NavigatorHelperSupport()
    NavigatorTool.logPlugin = LogPlugin()
  }
}

class LogPlugin: NavigatorLogPlugin {
  func handleLogError(_ error: Error, tag: String?) {
    print("\(resolveTagString(tag))error is \(error)")
  }
  
  func handleLog(message: Any, tag: String?) {
    print("\(resolveTagString(tag))\(message)")
  }
}

extension LogPlugin {
  func resolveTagString(_ tag: String?) -> String {
    guard let tag = tag else {
      return ""
    }
    
    return "[\(tag)] "
  }
}


