//
//  NewPostViewController.swift
//  30sreview
//
//  Created by secwang on 08/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import Cocoa

class NewPostViewController: NSViewController {
    

    @IBOutlet var mytextview: NSTextView!
    
    @IBOutlet var frame: NSView!
    
    
    @IBAction func sendContent(_ sender: Any) {
        
        let newPost = mytextview.textStorage?.string
        print(newPost ?? "postNotExist")
        print((newPost != nil) && !(newPost?.isEmpty)!)
        if((newPost != nil) && !(newPost?.isEmpty)!){
            PersistentTheShareInstance.sharedInstance.insertPost(content: newPost!)
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frame.layer?.backgroundColor = NSColor.white.cgColor
      
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    override func viewWillAppear() {
        
    }

}
