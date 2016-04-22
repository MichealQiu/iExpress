//
//  AppDelegate.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/21.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import UIKit
import MMDrawerController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var drawerController: MMDrawerController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        1.创建window
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
//        2.创建根控制器
        let centerViewController = defaultController()
//        let centerNav = UINavigationController(rootViewController: centerViewController)
        
        let leftMenuViewControllor = LeftMenuViewController()
        drawerController = MMDrawerController(centerViewController: centerViewController, leftDrawerViewController: leftMenuViewControllor)
        drawerController.maximumLeftDrawerWidth = UIScreen.mainScreen().bounds.maxX * 0.8
        //手势
        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All
        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All
        //设置动画，这里是设置打开侧栏透明度从0到1
        drawerController.setDrawerVisualStateBlock { (drawerController, drawerSide, percentVisible) in
            var sideDrawerViewController:UIViewController?
            if(drawerSide == MMDrawerSide.Left){
                sideDrawerViewController = drawerController.leftDrawerViewController;
            }
            sideDrawerViewController?.view.alpha = percentVisible
        }
        
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()

        customizeAppearance()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    MARK: - Method add by myself
    private func defaultController() -> UIViewController {
        return MainViewController()
    }
    
    func customizeAppearance() {
        UITabBar.appearance().tintColor = UIColor.lightGreenColor()
    }

}

