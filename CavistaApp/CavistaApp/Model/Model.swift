//
//  Data.swift
//  CavistaApp
//
//  Created by Apple on 07/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import Foundation
import RealmSwift
// MARK: - Realm
class OfflineItems: Object{
    @objc dynamic var id = ""
    @objc dynamic var date = ""
    @objc dynamic var data = ""
    @objc dynamic var type = ""
}

// MARK: - Codable
struct Items: Codable {
    let id: String
    let type: TypeEnum
    let date: String?
    let data: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
    case other = "other"
    case text = "text"
}
extension Items {
    var sortByOption: Int
    { return ["image","text","other"].firstIndex(of: type.rawValue) ?? 0 }
}

typealias DataList = [Items]

