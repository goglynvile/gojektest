//
//  DataFetcher.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

public typealias ArrayCompletionHandler = (_ result : Array<Any>?,_ error: String?) -> Void
public typealias DictionaryCompletionHandler = (_ result : Dictionary<String, Any>?,_ error: String?) -> Void

class DataManager {
    static let shared = DataManager()
    
    func fetchAllContacts(completion: @escaping ArrayCompletionHandler) {
        APIClient.makeHTTPRequest(url: Constant.Server.contacts, method: .get, parameters: nil) { (data, error) in
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
    func fetchContact(for id: Int, completion: @escaping DictionaryCompletionHandler) {
        APIClient.makeHTTPRequest(url: Constant.Server.contact(id: id), method: .get, parameters: nil) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    completion(dictionary, nil)
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
    func addContact(item: Parameters, completion: @escaping DictionaryCompletionHandler) {
        
        APIClient.makeHTTPRequest(url: Constant.Server.contacts, method: .post, parameters: item) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    completion(dictionary, nil)
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
