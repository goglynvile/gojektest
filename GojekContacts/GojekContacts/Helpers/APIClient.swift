//
//  APIClient.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
}
public typealias Parameters = [String: Any]
public typealias DataCompletionHandler = (_ data : Data?,_ error: Error?) -> Void

class APIClient {
    class func makeHTTPRequest(url: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping DataCompletionHandler) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let parameters = parameters {
            
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
           completion(data, error)
        }
        dataTask.resume()
    }
}
