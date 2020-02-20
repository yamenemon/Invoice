//
//  IVPaymentModel.swift
//  Invoice
//
//  Created by Scrupulous on 11/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVPaymentModel: NSObject {
    
    var identifier: String?
    var name: String?
    var createdDate: String?
    var updatedDate: String?
    
    convenience init(withInformation information:[String : Any?]) {
        
        self.init()
        self.updatedDate = information["updatedAt"] as? String
        self.name = information["name"] as? String
        self.identifier = information["_id"] as? String
        self.createdDate = information["createdAt"] as? String
        
    }

}
