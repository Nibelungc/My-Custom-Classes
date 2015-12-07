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
    let welcomeViewController = WelcomePageController(withImages: images)
    
    /* Optional customization */
    welcomeViewController.pageControl.currentPageIndicatorTintColor = UIColor.TIBrightBlueColor()
    welcomeViewController.closeButton.backgroundColor = UIColor.TIBlueColor()
    
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
