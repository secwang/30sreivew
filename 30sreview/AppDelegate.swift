//
//  AppDelegate.swift
//  30sreview
//
//  Created by secwang on 06/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
  
        
        PersistentTheShareInstance.sharedInstance.createTables(PersistentTheShareInstance.sharedInstance.db!)
   
        
        print( PersistentTheShareInstance.sharedInstance.db?.description ??  "db not create")
        
        print("hello")

        
        
        
        // Insert code here to initialize your application
        
        
        //        window.isMovableByWindowBackground = true
        //        window.titleVisibility = NSWindowTitleVisibility.hidden

        
        //        let viewController = ViewController()
        //        window.contentViewController = viewController
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
}

