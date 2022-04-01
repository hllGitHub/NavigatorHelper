//
//  NavigatorLogPlugin.swift
//  NavigatorHelper
//
//  Created by Jeffrey hu on 2022/3/31.
//

import Foundation

/// LogPlugin of navigator that the business side can output logs to the corresponding tool or file.
public protocol NavigatorLogPlugin: AnyObject {
  
  /// Catch the error or exception of navigatorHelper.
  /// Call timing is internal error thread
  ///
  /// - Parameters:
  ///   - error: error
  ///   - tag: log tag
  func handleLogError(_ error: Error, tag: String?)
  
  /// Handle log mesage
  /// - Parameters:
  ///   - message: log message
  ///   - tag: log tag
  func handleLog(message: Any, tag: String?)
}
