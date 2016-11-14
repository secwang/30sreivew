//
//  File.swift
//  30sreview
//
//  Created by secwang on 10/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import Cocoa
import SQLite

class ListViewController: NSViewController , NSTableViewDataSource, NSTableViewDelegate {
    
    
    var items = [Row]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts))
            

        } catch {
            print("some error")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let result : ReviewCell = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! ReviewCell
        
        result.review.stringValue = items[row].get(ReviewTable.entry)
        
        return result
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int{
//        return items.count
        return items.count
    }
    
    
}
