//
//  Realm.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/09/05.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import Foundation
import RealmSwift

class Book: Object{
    
    @objc dynamic var textName: String = ""
}

class Subject: Object{
    @objc dynamic var id = 0
    @objc dynamic var name: String  = ""
//    let books = List<Book>()
    // idをプライマリキーに設定
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
