//
//  DB.swift
//  30sreview
//
//  Created by secwang on 09/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import SQLite

class Persistent : NSObject {
    var db:Connection? = nil
    override init() {
//        let path = NSSearchPathForDirectoriesInDomains(
//            .applicationSupportDirectory, .userDomainMask, true
//            ).first! + Bundle.main.bundleIdentifier!
//        
//        // create parent directory iff it doesn’t exist
//        do{
//        try FileManager.default.createDirectory(
//            atPath: path, withIntermediateDirectories: true, attributes: nil
//        )
        do{
        let path = "/Users/secwang/Documents"
        print(path)
        db = try Connection("\(path)/entry.sqlite3")
            
        
        } catch {
            print("error get connnection")
        }
        
    }
    
    func createTables(_ connection: Connection){
        
       
        do{
            try db?.run(ReviewTable.posts.create(ifNotExists: true) { t in
                t.column(ReviewTable.id,primaryKey: true)
                t.column(ReviewTable.entry)
                t.column(ReviewTable.createAt)
                t.column(ReviewTable.updateAt)

            })
      
        } catch {
            print ("error on create table.")
        }
    }
    
    func insertPost(content: String) -> Bool {
        let insert = ReviewTable.posts.insert(ReviewTable.entry <- content,
                                              ReviewTable.createAt <- Date(),
                                              ReviewTable.updateAt <- Date()
        )
        var yes = false
        do{

            yes = ((try db?.run(insert)) != nil)
        } catch {
            print("Error info: \(error)")
        }
        return yes

    }
    
    
}
