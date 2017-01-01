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

    static let countDown = 30
    var currentCountDown = 0

    var startCountDown = true

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
            self.startCountDown = true
            self.timer.stringValue =  String(NewPostViewController.countDown) + "S"
            currentCountDown = NewPostViewController.countDown
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
        DispatchQueue.global().async {
                    self.startCountDownFunc()
        }

    }

    func startCountDownFunc(){
        print("hello")
        let newPost = mytextview.textStorage?.string

        if ((newPost != nil) && !((newPost?.isEmpty)!)){
            if(startCountDown){
                print("start render countdown")
                startCountDown = false
                currentCountDown = NewPostViewController.countDown
                while currentCountDown > 0  {
                    if(!startCountDown){
                        currentCountDown = currentCountDown - 1
                        Thread.sleep(forTimeInterval: 1)
                        DispatchQueue.main.async {
                            self.timer.stringValue =  String(self.currentCountDown) + "S"
                        }
                    } else{
                        break
                    }
                }

            }
        }
    }

}
