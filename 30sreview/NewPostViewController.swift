//
//  NewPostViewController.swift
//  30sreview
//
//  Created by secwang on 08/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import Cocoa

class NewPostViewController: NSViewController , NSTextViewDelegate{
    

    @IBOutlet var mytextview: NSTextView!
    
    @IBOutlet var frame: NSView!
    
    @IBOutlet weak var timer: NSTextField!
    
    @IBAction func sendContent(_ sender: Any) {
        
        let newPost = mytextview.textStorage?.string
        print(newPost ?? "postNotExist")
        print((newPost != nil) && !(newPost?.isEmpty)!)
        var insertSuccess = false
        if((newPost != nil) && !(newPost?.isEmpty)!){
            insertSuccess = PersistentTheShareInstance.sharedInstance.insertPost(content: newPost!)
        }
        print("insert post success\(insertSuccess)")

        if(insertSuccess){
            mytextview.textStorage?.setAttributedString(NSAttributedString())
        }
        
        if (self.parent?.childViewControllers.count == 2){
            let tabViewContorller = self.parent as! ReviewTabViewController
            tabViewContorller.selectedTabViewItemIndex = 1
        }

        


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frame.layer?.backgroundColor = NSColor.white.cgColor
        self.mytextview.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewWillAppear() {
        // Update the view, if already loaded.
    }
    // add text change callback.
    func textDidChange(_ notification: Notification) {
        guard (notification.object as? NSTextView) != nil else { return }
        print(mytextview.string ?? "haha")
    }

}
