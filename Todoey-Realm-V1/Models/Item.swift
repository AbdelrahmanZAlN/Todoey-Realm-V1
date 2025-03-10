//
//  Item.swift
//  Todoey-Realm-Version
//
//  Created by Abdelrahman Zain on 25/02/2025.
//

import Foundation
import RealmSwift

class Item : Object {
    @Persisted var title : String = ""
    @Persisted var isDone : Bool = false
    @Persisted var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

}
