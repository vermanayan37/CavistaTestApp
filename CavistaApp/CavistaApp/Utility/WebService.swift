//
//  WebService.swift
//  CavistaApp
//
//  Created by Apple on 08/09/20.
//  Copyright © 2020 NayanV. All rights reserved.
//

import Foundation
import Alamofire
class WebService:NSObject{
    class func getResponse<T:Decodable>(url: String, type: T.Type, Completion: @escaping (T?) -> ()) {
        
         AF.request(url).responseJSON { (response) in
            let decoder = JSONDecoder()
            do {
                if let data = response.data {
                    let res = try decoder.decode(T.self, from: data)
                    Completion(res)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

