//
//  NavigatorTool.swift
//  NavigatorHelper
//
//  Created by Jeffrey hu on 2022/3/31.
//

import Foundation

/// Assistant tool for `NavigationHelper`.
public class NavigatorTool {
  
  /// The requirement shoule be implement that support helper.
  public static var requirement: NavigatorHelperRequirement? {
    get {
      return NavigatorHelper.shared.requirement
    }
    set {
      NavigatorHelper.shared.requirement = newValue
    }
  }
  
  /// The logPlugin could be implement that support helper.
  /// Default is `NavigatorHelperLogPlugin` that use `print`.
  /// If you need to collect logs, you can implement this.
  public static var logPlugin: NavigatorLogPlugin? {
    get {
      return NavigatorHelper.shared.logPlugin
    }
    set {
      NavigatorHelper.shared.logPlugin = newValue
    }
  }
}
