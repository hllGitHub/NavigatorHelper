//
//  NavigatorHelper.swift
//  NavigatorHelper
//
//  Created by Jeffrey hu on 2022/3/31.
//

import Foundation

protocol NavigatorProtol {
  
  func handleNotificationLink(_ linkURL: URL?)
  
  func handleEntry(with url: URL?) -> Bool
  
  func dispatchPendingURLIfHave()
  
  func clearPendingURL()
}

public final class NavigatorHelper {
  public static let shared = NavigatorHelper()
  private let loggerTag = "NavigatorHelper"
  
  private var pendingHandleURL: URL?
  private var pendingNotificationLinkURL: URL?
  
  public var requirement: NavigatorHelperRequirement?
  public var logPlugin: NavigatorLogPlugin? = NavigatorHelperLogPlugin()
  
  public init() {}
}

extension NavigatorHelper: NavigatorProtol {
  
  /// Handle the link URL form notification.
  /// - Parameter linkURL: link URL
  public func handleNotificationLink(_ linkURL: URL?) {
    logPlugin?.handleLog(message: "Will handle notificationLink \(String(describing: linkURL))", tag: loggerTag)
    guard let linkURL = linkURL else {
      return
    }
    
    guard let requirement = requirement else {
      logPlugin?.handleLogError(NavigatorHelperError.invalidRequirement, tag: loggerTag)
      return
    }
    
    guard requirement.canHandleURL else {
      pendingNotificationLinkURL = linkURL
      logPlugin?.handleLog(message: "Can not handle notification link \(linkURL)", tag: loggerTag)
      return
    }
    
    pendingNotificationLinkURL = nil
    // handleLinkURL
    requirement.handleLinkURL(url: linkURL, whiteListFilter: false)
  }
  
  @discardableResult
  /// Handle entry form sourceAplication as safari or third app.
  /// External incoming routes need to be whitelisted for security.
  /// - Parameters:
  ///   - url: link URL
  /// - Returns: Whether it can be handled.
  public func handleEntry(with url: URL?) -> Bool {
    logPlugin?.handleLog(message: "Will handleEntry \(String(describing: url))", tag: loggerTag)
    guard let url = url else {
      return false
    }
    
    guard let requirement = requirement else {
      logPlugin?.handleLogError(NavigatorHelperError.invalidRequirement, tag: loggerTag)
      return false
    }
    
    guard requirement.canHandleURL else {
      logPlugin?.handleLog(message: "Can not handle entry: \(String(describing: pendingHandleURL))", tag: loggerTag)
      pendingHandleURL = url
      return true
    }
    
    pendingHandleURL = nil
    
    // Resolve UniversalLink
    guard let result = requirement.resolveUniversalLink(url: url) else {
      logPlugin?.handleLogError(NavigatorHelperError.illegalUniversalLink, tag: loggerTag)
      logPlugin?.handleLog(message: "Invalid universalLink: \(url)", tag: loggerTag)
      return false
    }
    
    // Handle link with whiteListFilter
    requirement.handleLinkURL(url: result, whiteListFilter: true)
    return true
  }
  
  /// Dispatch pending URL if have
  /// This can be called when the home page has been rendered or when the App is active.
  public func dispatchPendingURLIfHave() {
    logPlugin?.handleLog(message: "Will dispatch pendingURL: \(String(describing: pendingHandleURL))", tag: loggerTag)
    handleEntry(with: pendingHandleURL)
    handleNotificationLink(pendingNotificationLinkURL)
  }
  
  /// Clear all pending URL and sourceApplication.
  public func clearPendingURL() {
    pendingHandleURL = nil
    pendingNotificationLinkURL = nil
  }
}

class NavigatorHelperLogPlugin: NavigatorLogPlugin {
  private let loggerTag = "NavigatorHelper"
  
  func handleLogError(_ error: Error, tag: String?) {
    print("[\(tag ?? loggerTag)] error is \(error)")
  }
  
  func handleLog(message: Any, tag: String?) {
    print("[\(tag ?? loggerTag)] \(message)")
  }
}
