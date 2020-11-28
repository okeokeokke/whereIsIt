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
    @objc dynamic var textSubjectName: String = ""
    @objc dynamic var status: String  = ""
}

class Subject: Object{
//    @objc dynamic var id = 0
    @objc dynamic var name: String  = ""
    @objc dynamic var colorImage: Data?
//    @objc dynamic var r:Float = 0.0
//    @objc dynamic var g:Float = 0.0
//    @objc dynamic var b:Float = 0.0
//    let books = List<Book>()
    // idをプライマリキーに設定
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
extension UIColor {
    class func hex ( string : String, alpha : CGFloat) -> UIColor {
        let string_ = string.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: string_ as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.white;
        }
    }
}
//rgbのクラスを加える
