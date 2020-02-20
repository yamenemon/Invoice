//
//  Data+Extension.swift
//  Invoice
//
//  Created by Scrupulous on 8/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

extension Data {
    mutating func appendString(string: String) {
        let data = string.data(
            using: String.Encoding.utf8,
            allowLossyConversion: true)
        append(data!)
    }
}
