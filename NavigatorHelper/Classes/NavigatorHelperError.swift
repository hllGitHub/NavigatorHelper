//
//  NavigatorHelperError.swift
//  NavigatorHelper
//
//  Created by Jeffrey hu on 2022/4/1.
//

import Foundation

/// The error of `NavigationHelper`
public enum NavigatorHelperError: Error, CustomStringConvertible {
  case invalidRequirement
  case illegalUniversalLink
  
  public var description: String {
    switch self {
    case .invalidRequirement:
      return "Invalid navigatorHelperRequirement, should support navigatorTool about requirement."
    case .illegalUniversalLink:
      return "Illegal universalLink, should keep illegal and safe"
    }
  }
}
