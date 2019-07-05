//
//  DataFetcher.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

// MARK: Redefinition


struct Server {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
    static let contacts = "\(Server.baseUrl)/contacts.json"
    
    static func contact(id: Int) -> String {
        return "\(Server.baseUrl)/contacts/\(id).json"
    }
}

class DataManager {
    static let shared = DataManager()
    
    func fetchAllContacts(completion: @escaping ArrayCompletionHandler) {
        APIClient.makeHTTPRequest(url: Server.contacts, method: .get, parameters: nil) { (data, error) in
            if error == nil {
                if let data = data {
                    let array = data.toJSONArray()
                    completion(array, nil)
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    func fetchContact(for id: Int, completion: @escaping DictionaryCompletionHandler) {
        APIClient.makeHTTPRequest(url: Server.contact(id: id), method: .get, parameters: nil) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    completion(dictionary, nil)
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    func addContact(item: Parameters, completion: @escaping DictionaryCompletionHandler) {
        
        APIClient.makeHTTPRequest(url: Server.contacts, method: .post, parameters: item) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    if let nError = dictionary?["errors"] as? Array<String> {
                        print("addContact nError: \(nError)")
                        completion(nil, nError.joined(separator: ", "))
                    }
                    else {
                        completion(dictionary, nil)
                    }
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    func editContact(id: Int, item: Parameters, completion: @escaping DictionaryCompletionHandler) {
        
        APIClient.makeHTTPRequest(url: Server.contact(id: id), method: .put, parameters: item) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    if let nError = dictionary?["errors"] as? Array<String> {
                        print("editContact nError: \(nError)")
                        completion(nil, nError.joined(separator: ", "))
                    }
                    else {
                        completion(dictionary, nil)
                    }
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    func deleteContact(id: Int, completion: @escaping DictionaryCompletionHandler) {
        
        APIClient.makeHTTPRequest(url: Server.contact(id: id), method: .delete, parameters: nil) { (data, error) in
            if error == nil {
                if let data = data {
                    let dictionary = data.toJSONDictionary()
                    if let nError = dictionary?["errors"] as? Array<String> {
                        print("deleteContact nError: \(nError)")
                        completion(nil, nError.joined(separator: ", "))
                    }
                    else {
                        completion(dictionary, nil)
                    }
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
    func downloadImage(url: String, completion: @escaping DataCompletionHandler) {
        APIClient.makeHTTPRequest(url: url, method: .get, parameters: nil) { (data, error) in
            if error == nil {
                if let data = data {
                    completion(data, nil)
                }
                else {
                    completion(nil, Constant.Text.null)
                }
            }
            else {
                completion(nil, error)
            }
        }
    }
}
