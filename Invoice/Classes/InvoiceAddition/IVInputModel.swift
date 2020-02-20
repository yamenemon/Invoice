//
//  IVInputModel.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

enum VSInputOptionType {
    case text
    case picker
    case file
}

enum VSInputType {
    case title
    case amount
    case date
    case category
    case vendor
    case payment
    case note
    case image
}

class IVInputModel: NSObject {
    
    var inputType : VSInputType?
    var optionType : VSInputOptionType?
    var inputValue : Any?
    var placeholderValue : Any?
  
    convenience init(withInputType type:VSInputType?, withOptionType optionType: VSInputOptionType?, withValue value: Any?, withPlaceholder text: Any?) {
        self.init()
        self.inputType = type
        self.optionType = optionType
        self.inputValue = value
        self.placeholderValue = text
    }

}
