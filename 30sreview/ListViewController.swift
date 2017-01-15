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

    @IBOutlet weak var mytableview: NSTableView!

    @IBAction func startSearch(_ sender: Any) {
        var query = search.stringValue
        if ((query != nil) && !(query.isEmpty)){
            query = "%"+query + "%"
            do {
                items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.order(ReviewTable.id.desc)
                .filter(ReviewTable.entry.like(query))))
                self.representedObject = items
                mytableview.reloadData()
            } catch {
                print("some error in start query.")
            }
        } else{

            do {

            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.order(ReviewTable.id.desc)))
            self.representedObject = items
            mytableview.reloadData()
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
        self.mytableview.target = self
        self.mytableview.doubleAction = #selector(tableViewDoubleClick(_:))


        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.order(ReviewTable.id.desc)))
            self.representedObject = items

        } catch {
            print("some error")
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(){
        super.viewDidAppear()
        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.order(ReviewTable.id.desc)))
            self.representedObject = items
            mytableview.reloadData()
            print("update success")
        } catch {
            
            print("some error")
        }
    }

    
    func tableViewDoubleClick(_ sender:AnyObject) {
        print("into")
        print(self.mytableview.clickedRow)
        
    
    }

    override var representedObject: Any? {
        didSet {
            print("\(items.count)")
            // Update the view, if already loaded.
        }
    }
    
    override func rightMouseDown(with event: NSEvent){
     
        var index = mytableview.selectedRow
        
        if(index > -1){
            let editMenuItem = NSMenuItem()
            editMenuItem.title = "edit"
            editMenuItem.keyEquivalent = "e"
            editMenuItem.action  = #selector(editItem(_:))

            
            let deleteMenuItem = NSMenuItem()
            deleteMenuItem.title = "delete"
            deleteMenuItem.keyEquivalent = "d"
            deleteMenuItem.action  = #selector(deleteItem(_:))
            
            let rightMenu = NSMenu()
            rightMenu.addItem(editMenuItem)
            rightMenu.addItem(deleteMenuItem)
            NSMenu.popUpContextMenu(rightMenu,  with: event,for: mytableview)

        }
        
    }
    
    func editItem (_ sender:AnyObject) {
        print("need edit")
        self.performSegue(withIdentifier: "ShowEditView", sender: self)
    }

    
    func deleteItem (_ sender:AnyObject) {
        
        print("delete Item")
        let row = mytableview.selectedRow
        let raw = items[row]
        let id = raw.get(ReviewTable.id)
        
        let needDeleted = ReviewTable.posts.filter(ReviewTable.id == id)

        do {
            if try (PersistentTheShareInstance.sharedInstance.db?.run(needDeleted.delete()))! > 0 {
                print("deleted ", id)
            } else {
                print("id not found")
            }
        } catch {
            print("delete failed: \(error)")
        }
        
        do{
            items = Array(try PersistentTheShareInstance.sharedInstance.db!.prepare(ReviewTable.posts.order(ReviewTable.id.desc)))
            self.representedObject = items
            mytableview.reloadData()
            print("update success")
        } catch {
            
            print("some error")
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
