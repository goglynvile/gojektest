//
//  DataFetcher.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

public typealias ArrayCompletionHandler = (_ result : Array<Any>?,_ error: String?) -> Void

class DataFetcher {
    static let shared = DataFetcher()
    
    func fetchAllContacts(completion: @escaping ArrayCompletionHandler) {
        
        APIClient.makeHTTPRequest(url: Constant.Server.contacts, method: .get, parameters: nil) { (data, error) in
            //print("Fetching all contacts: \(data?.toJSONArray())")
            if error == nil {
                if let data = data {
                    let array = data.toJSONArray()
                    completion(array, nil)
                }
                else {
                    completion(nil, "Fetched data is null.")
                }
            }
            else {
                completion(nil, error?.localizedDescription)
            }
        }
    }
}
