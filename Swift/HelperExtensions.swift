
import UIKit

class HelperExtensions: NSObject {
    
}

class Utility{
    class func classNameAsString(obj: Any) -> String {
        //prints more readable results for dictionaries, arrays, Int, etc
        return _stdlib_getDemangledTypeName(obj).componentsSeparatedByString(".").last!
    }
}

extension UIViewController {
    
    class func viewControllerFromStoryboard(identifier: String = Utility.classNameAsString(self)) -> UIViewController {
        let storyboardName = NSBundle.mainBundle().infoDictionary!["UIMainStoryboardFile"] as? String ?? "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(identifier)
    }
}

extension UIDevice {
    
    func isIphone4() -> Bool {
        let iphone4Size = CGSizeMake(320.0, 480.0)
        let currentScreenSize = UIScreen.mainScreen().bounds.size
        let iphone4AspectRatio = iphone4Size.height/iphone4Size.width
        let currentAspectRatio = currentScreenSize.height/currentScreenSize.width
        return currentAspectRatio == iphone4AspectRatio
    }
}

extension NSError{
    
    class func errorWithDescription(description: String, code: Int = 0) -> NSError{
        let domain = NSBundle.mainBundle().bundleIdentifier!
        return NSError(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
}

extension String{
    
    func encodeForURL() -> String?{
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
    }
}

extension String {
    
    func componentsSeparatedByStrings(separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.componentsSeparatedByString(separator) }
            }.map { $0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) }
    }
    
    var lastPathComponent: String {
        get {
            return (self as NSString).lastPathComponent
        }
    }
    var pathExtension: String {
        get {
            return (self as NSString).pathExtension
        }
    }
    var stringByDeletingLastPathComponent: String {
        get {
            return (self as NSString).stringByDeletingLastPathComponent
        }
    }
    var stringByDeletingPathExtension: String {
        get {
            return (self as NSString).stringByDeletingPathExtension
        }
    }
    var pathComponents: [String] {
        get {
            return (self as NSString).pathComponents
        }
    }
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.stringByAppendingPathComponent(path)
    }
    
    func stringByAppendingPathExtension(ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.stringByAppendingPathExtension(ext)
    }
}