//
//  Category.swift
//  Todoey-Realm-Version
//
//  Created by Abdelrahman Zain on 25/02/2025.
//

import Foundation
import RealmSwift
class Category: Object {
    @Persisted var title: String = ""
    @Persisted var items = List<Item>()
}
