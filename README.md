# NavigatorHelper

[![CI Status](https://img.shields.io/travis/hlltd/NavigatorHelper.svg?style=flat)](https://travis-ci.org/hlltd/NavigatorHelper)
[![Version](https://img.shields.io/cocoapods/v/NavigatorHelper.svg?style=flat)](https://cocoapods.org/pods/NavigatorHelper)
[![License](https://img.shields.io/cocoapods/l/NavigatorHelper.svg?style=flat)](https://cocoapods.org/pods/NavigatorHelper)
[![Platform](https://img.shields.io/cocoapods/p/NavigatorHelper.svg?style=flat)](https://cocoapods.org/pods/NavigatorHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

`NavigatorHelper` is only routing middleware, used to process the routes that cannot be opened in time to be called at the appropriate time. If you want to do App routing, you can implement it extra or use a third tool.

## Requirements

iOS 10.0, Swift 4.0+

## Installation

NavigatorHelper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NavigatorHelper'
```

## Usage

### Step 1

You need to implement `NavigatorHelperRequirement`

eg:

``` swift
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

```

### Step 2

Declare `NavigatorTool.requirement`, this is a necessary step.

eg:

``` swift
NavigatorTool.requirement = NavigatorHelperSupport()
```

### Step 3

Use `NavigatorHelper`

Handle notifications or incoming external urls and save if routing behavior cannot be performed immediately, eg:

``` swift
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

```
You can call `NavigatorHelper.shared.dispatchPendingURLIfHave()` whenever your app is activated or wherever you want to process pending urls.

### Option Step

You can implement `NavigatorLogPlugin` that the business side can output logs to the corresponding tool or file.

eg:

``` swift
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
```

and

``` swift
NavigatorTool.logPlugin = LogPlugin()
```

## Author

hlltd, hllfj922@gmail.com

## License

NavigatorHelper is available under the MIT license. See the LICENSE file for more info.
