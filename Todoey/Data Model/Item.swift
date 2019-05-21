//
//  Item.swift
//  Todoey
//
//  Created by Admir Sabanovic on 2019-05-21.
//  Copyright © 2019 Admir Sabanovic. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
