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

class ListViewController: NSViewController , NSTableViewDataSource, NSTableViewDelegate ,NSSearchFieldDelegate{
   
    
    @IBOutlet weak var search: NSSearchField!

    @IBOutlet weak var tableview: NSTableView!

    @IBAction func startSearch(_ sender: Any) {
        var query = search.stringValue
        if ((query != nil) && !(query.isEmpty)){
            query = "%"+query + "%"
            do {
                items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.filter(ReviewTable.entry.like(query))))
                self.representedObject = items
                tableview.reloadData()
            } catch {
                print("some error in start query.")
            }
        } else{

            do {

            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts))
            self.representedObject = items
            tableview.reloadData()
            print("restore it")
            } catch {
                print("some error in start query.")
            }

        }


    }
    

    var items = [Row]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.search.delegate = self

        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts))
            self.representedObject = items
            
            

        } catch {
            print("some error")
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(){
        super.viewDidAppear()
        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts))
            self.representedObject = items
            tableview.reloadData()
            print("update success")
        } catch {
            
            print("some error")
        }
    }

    


    override var representedObject: Any? {
        didSet {
            print("\(items.count)")
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
