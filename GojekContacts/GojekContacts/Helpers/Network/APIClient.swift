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
public typealias DataCompletionHandler = (_ data : Data?,_ error: String?) -> Void
public typealias ArrayCompletionHandler = (_ result : Array<Any>?,_ error: String?) -> Void
public typealias DictionaryCompletionHandler = (_ result : Dictionary<String, Any>?,_ error: String?) -> Void


class APIClient {
    class func makeHTTPRequest(url: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping DataCompletionHandler) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = data//parameters.description.data(using: .utf8)
            }
            catch {
                
            }
        }
        print("request: \(request) body: \(request.httpBody)")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
           completion(data, error?.localizedDescription)
        }
        dataTask.resume()
    }
}
