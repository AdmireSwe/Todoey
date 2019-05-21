//
//  Category.swift
//  Todoey
//
//  Created by Admir Sabanovic on 2019-05-21.
//  Copyright © 2019 Admir Sabanovic. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
     @objc dynamic var name : String = ""
    let items = List<Item>()
}
