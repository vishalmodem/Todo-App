//
//  Items.swift
//  Todo App
//
//  Created by Shanker Goud on 3/18/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import Foundation
import RealmSwift

class TodoClass : Object{
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    
    var child = LinkingObjects(fromType: Category.self, property: "items")
    
}

