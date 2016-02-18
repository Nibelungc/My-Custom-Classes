# My-Custom-Classes

## WelcomePageController

`WelcomePageController` is a subclass of the `UIViewController` based on the `UIPageViewController`. Simple page contoller with welcome screens, page indicator and close button.
Shows only once per install. Sets as root view controller for the application window.

### Usage

For initialization need an array with images and your initial view controller

``` swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let images = [
        UIImage(named: "5.5-inch (iPhone 6+) - Screenshot 1.jpg"),
        UIImage(named: "5.5-inch (iPhone 6+) - Screenshot 2.jpg"),
        UIImage(named: "5.5-inch (iPhone 6+) - Screenshot 3.jpg"),
        UIImage(named: "5.5-inch (iPhone 6+) - Screenshot 4.jpg")
    ].map(){$0!}
    
    let initialViewController = UINavigationController.viewControllerFromStoryboard("InitialNavigationViewController")
    
    /* Initialization */
    let welcomeViewController = WelcomePageController(withImages: images, tintColor: UIColor.TIBrightBlueColor())
    
    /* Optional customization */
    let initialViewController = UINavigationController.viewControllerFromStoryboard("InitialNavigationViewController")

    welcomeViewController.finishButton.backgroundColor = UIColor.TIBlueColor()
    
    UIApplication.sharedApplication().setRootViewController(initialViewController, withWelcomePageController: welcomeViewController)
    
    /* Setup */
    UIApplication.sharedApplication().setRootViewController(initialViewController, withWelcomePageController: welcomeViewController)
    return true
}
```
If you want to show it elsewhere after initialization, you can take the saved instance
``` swift
guard let helpController = WelcomePageController.welcomeController else { return }
self.presentViewController(helpController, animated: true, completion: nil)
```
## UIViewController+EmptyBackButton

`UIViewController+EmptyBackButton` category for the `UIViewController`. Removes back button titles from every view controller. Uses swizzling.

### Usage

Add 'UIViewController+EmptyBackButton.h` and `UIViewController+EmptyBackButton.m` to your project

## UIButton+ActionHandler

Example of a category for the UIButton to handle action via block

### Usage

import "UIButton+ActionHandler.h"
``` obj-c
    UIButton* button = create and customize button...;
    
    [button setActionHandler: ^(UIButton* sender){
        NSLog(@"Button tapped with title [%@]", sender.titleLabel.text);
    }];
```
