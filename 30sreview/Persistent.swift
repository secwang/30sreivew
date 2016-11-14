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
                t.column(ReviewTable.entry)
            })
      
        } catch {
            print ("error on create table.")
        }
    }
    
    func insertPost(content: String) {
        
        let insert = ReviewTable.posts.insert(ReviewTable.entry <- content)
        do{

        _ = try db?.run(insert)
        } catch {
            print ("error on insert \(content)")
        }

    }
    
    
}
