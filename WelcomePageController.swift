//
//  WelcomePageController.swift
//  TranslateIt
//
//  Created by Denis Baluev on 04/12/15.
//  Copyright © 2015 Denis Baluev. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController {
    
    /** Public */
    
    var closeButton: UIButton
    var pageControl: UIPageControl
    var statusBarHidden = true
    var resetPageOnWillAppear = true
    let viewControllers: [UIViewController]
    
    static var welcomeController: WelcomePageController?
    static var wasShown: Bool {
        get {
           return NSUserDefaults.standardUserDefaults().boolForKey(kWelcomePagecontrollerWasShown)
        }
        set {
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: kWelcomePagecontrollerWasShown)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    /** Private */
    
    static private let kWelcomePagecontrollerWasShown = "kWelcomePagecontrollerWasShown"
    private var initialViewController: UIViewController!
    private let pageController: UIPageViewController
    private let DefaultPadding: CGFloat = 8.0
    
    //  MARK: - Initialization
    
    convenience init(withImages images: [UIImage]){
        let controllersWithImages: [UIViewController] = images.map() { image in
            let viewController = UIViewController()
            let imageView = UIImageView(frame: viewController.view.bounds)
            imageView.contentMode = .ScaleAspectFit
            imageView.image = image
            imageView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            viewController.view.addSubview(imageView)
            return viewController
        }
        self.init(viewControllers: controllersWithImages)
    }
    
    init(viewControllers controllers: [UIViewController]){
        viewControllers = controllers.isEmpty ? [WelcomePageController.placeholderViewController()] : controllers
        pageControl = UIPageControl()
        closeButton = UIButton(type: .Custom)
        pageController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        super.init(nibName: nil, bundle: nil)
        self.configureUIElements()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if (pageControl.currentPage != 0 && resetPageOnWillAppear){
            pageController.setViewControllers([viewControllers.first!], direction: .Forward, animated: true, completion: nil)
            pageViewController(pageController, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
        }
        
        if statusBarHidden {
            UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if statusBarHidden {
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
        }
    }
    
    //  MARK: - Setup UI
    
    private func configureUIElements() {
        
        /** PageController setup    */
        let firstControllerInArray = [viewControllers.first!]
        pageController.setViewControllers(firstControllerInArray, direction: .Forward, animated: true, completion: nil)
        pageController.view.frame = view.bounds
        pageController.delegate = self
        pageController.dataSource = self
        pageController.view.backgroundColor = UIColor.whiteColor()
        
        addChildViewController(pageController)
        view.addSubview(pageController.view)
        pageController.didMoveToParentViewController(self)
        
        /** PageControl setup   */
        pageControl.center = CGPointMake(view.center.x, CGRectGetMinY(view.bounds) + 20.0)
        pageControl.numberOfPages = viewControllers.count
        pageControl.pageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.5)
        pageControl.currentPageIndicatorTintColor = view.tintColor
        view.addSubview(pageControl)
        
        /** Close button setup  */
        let lastViewController = viewControllers.last!
        let padding = DefaultPadding * 3
        let bottomPadding = DefaultPadding * 2
        let buttonSize = CGSizeMake(CGRectGetWidth(view.bounds) - padding * 2, 50)
        closeButton.frame = CGRectMake(padding, CGRectGetHeight(view.bounds) - buttonSize.height - bottomPadding, buttonSize.width, buttonSize.height)
        closeButton.addTarget(self, action: "dismiss:", forControlEvents: .TouchUpInside)
        closeButton.setTitle("Начать пользоваться", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.titleLabel?.font = UIFont.systemFontOfSize(20.0)
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = CGRectGetMidY(closeButton.bounds)
        closeButton.backgroundColor = view.tintColor
        lastViewController.view.addSubview(closeButton)
    }
    
    //  MARK: - Helper methods
    
    private class func placeholderViewController(withText text: String = "You have to add at least one ViewController") -> UIViewController {
        let viewController = UIViewController.init()
        let messageLabel = UILabel.init(frame: viewController.view.bounds)
        messageLabel.textAlignment = .Center
        messageLabel.text = text
        viewController.view.addSubview(messageLabel)
        return viewController
    }
    
    private func viewControllerAtIndex(index: Int) -> UIViewController? {
        guard index >= 0 && index < viewControllers.count else { return nil }
        return viewControllers[index]
    }
    
    private func indexOfCurrentViewController() -> Int? {
        guard let currentViewControler = pageController.viewControllers?.last else { return nil }
        return viewControllers.indexOf(currentViewControler)
    }
    
    //  MARK: - Actions
    
    /*
      Dismiss if was presented. 
      If wasn't dismiss view controller after it has been shown at first time.
      Actually changes root view controller for window.
    */
    @objc private func dismiss(animated: Bool = true){
        if presentingViewController != nil {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            UIView.transitionWithView(view.window!, duration: 0.3, options: .TransitionCrossDissolve,
                animations: {
                    self.view.window?.rootViewController = self.initialViewController
                }, completion: nil)
            
        }
        WelcomePageController.wasShown = true
    }
    
}

//  MARK: - UIPageViewControllerDataSource

extension WelcomePageController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.indexOf(viewController) else { return nil }
        return viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllers.indexOf(viewController) else { return nil }
        return viewControllerAtIndex(index + 1)
    }
}

//  MARK: - UIPageViewControllerDelegate

extension WelcomePageController: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = indexOfCurrentViewController() ?? 0
    }
}

//  MARK: - UIApplication extension

extension UIApplication {
    
    func setRootViewController(rootVC: UIViewController, withWelcomePageController welcomeVC: WelcomePageController) {
        guard let applicationWindow = delegate?.window! else {
            print("[WelcomePageController]: Can't find application window")
            return
        }
        applicationWindow.rootViewController = WelcomePageController.wasShown ? rootVC : welcomeVC
        welcomeVC.initialViewController = rootVC
        WelcomePageController.welcomeController = welcomeVC
    }
    
}
