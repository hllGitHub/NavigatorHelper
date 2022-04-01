//
//  NavigatorHelperSupport.swift
//  NavigatorHelper_Example
//
//  Created by Jeffrey hu on 2022/4/1.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import NavigatorHelper

struct NavigatorHelperSupport: NavigatorHelperRequirement {
  // You can call the route jump function in App.
  func handleLinkURL(url: URL, whiteListFilter: Bool) {
    if whiteListFilter {
      print("Handle link URL \(url) and should whiteListFilter")
    } else {
      print("Handle link URL \(url)")
    }
  }
  
  var canHandleURL: Bool {
    return UIApplication.shared.applicationState == .active
  }
  
  func resolveUniversalLink(url: URL) -> URL? {
    // eg: resolve external url to "navigator://web?url=www.baidu.com" that can handle
    return URL(string: "navigator://web?url=www.baidu.com")
  }
}
