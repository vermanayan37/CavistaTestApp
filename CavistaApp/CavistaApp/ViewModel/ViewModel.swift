//
//  ViewModel.swift
//  CavistaApp
//
//  Created by Apple on 08/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire

class UserListViewModel {
    
    func getList(completion:@escaping([Items]?) -> ()) {
        if Connectivity.isConnectedToInternet() {
            WebService.getResponse(url: ApiUrl.itemList, type: [Items].self, Completion: { res in
                if let arr = res {
                    self.save(arrItems: arr)
                    completion(arr)
                } else {
                    completion(nil)
                }
            })
        } else {
            self.get(completion: {arr in
                completion(arr)
            })
        }
    }
    func save(arrItems: [Items]){
        let realm = try! Realm()
        let items = realm.objects(OfflineItems.self)
        if items.count == 0 {
            for item in arrItems {
                let object = OfflineItems()
                object.id = item.id
                object.date = item.date ?? ""
                object.type = item.type.rawValue
                object.data = item.data ?? ""
                do{
                    try realm.write {
                        realm.add(object)
                    }
                } catch {
                    print("Error saving data: \(error)")
                }
            }
        }
    }
    func get(completion: @escaping ([Items]) -> ()) {
        let realm = try! Realm()
        let items = realm.objects(OfflineItems.self)
        if items.count > 0 {
            var arrItems:[Items] = []
            for item in items {
                arrItems.append(Items(id: item.id, type: TypeEnum(rawValue: item.type) ?? .text, date: item.date, data: item.data))
            }
            completion(arrItems)
        } else {
            completion([])
        }
    }
}
