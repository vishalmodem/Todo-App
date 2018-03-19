//
//  Data.swift
//  Todo App
//
//  Created by Shanker Goud on 3/18/18.
//  Copyright © 2018 Shanker Goud. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name = ""
    let items = List<TodoClass>()
}
