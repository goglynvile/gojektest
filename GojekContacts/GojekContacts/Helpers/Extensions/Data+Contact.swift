//
//  Data+Contact.swift
//  GojekContacts
//
//  Created by Glynvile Satago on 04/07/2019.
//  Copyright © 2019 GoSatago. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    func toImage() -> UIImage? {
        let image = UIImage(data: self)
        return image
    }
    func toJSONDictionary() -> Dictionary<String, Any>? {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: self, options: [])
            return jsonResponse as? Dictionary<String, Any>
        }
        catch {
            return nil
        }
    }
    func toJSONArray() -> Array<Any>? {
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: self, options: [])
            return jsonResponse as? Array<Any>
        }
        catch {
            return nil
        }
    }
}
