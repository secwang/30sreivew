//
//  File.swift
//  30sreview
//
//  Created by secwang on 14/11/2016.
//  Copyright © 2016 secwang. All rights reserved.
//

import Foundation
import SQLite

class ReviewTable {
        static let posts = Table("posts")

        static let id = Expression<Int64>("id")
        static let entry = Expression<String>("entry")
        static let createAt =  Expression<Date>("create_at")
        static let updateAt =  Expression<Date>("update_at")

}
