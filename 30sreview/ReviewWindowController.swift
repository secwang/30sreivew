//
//  ReviewWindowController.swift
//  30sreview
//
//  Created by secwang on 10/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import Cocoa
class ReviewWindowController: NSWindowController{
    override func windowDidLoad() {
        super.windowDidLoad()
        
        if let window = self.window{
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true            
        }
    }
}
