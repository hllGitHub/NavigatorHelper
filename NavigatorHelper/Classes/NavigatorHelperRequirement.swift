//
//  NavigatorHelperRequirement.swift
//  NavigatorHelper
//
//  Created by Jeffrey hu on 2022/4/1.
//

import Foundation

public protocol NavigatorHelperRequirement {
  
  /// Whether the requirements for redirect URLS are met.
  var canHandleURL: Bool { get }
  
  /// Parse entry link from source application to universalLink.
  /// - Parameter url: Link url from source application.
  /// - Returns: UniversalLinkURL.
  func resolveUniversalLink(url: URL) -> URL?
  
  /// Handle link URL should jump
  /// - Parameters:
  ///   - url: Link URL.
  ///   - whiteListFilter: Whether whitelist filtering is required.
  func handleLinkURL(url: URL, whiteListFilter: Bool)
}
