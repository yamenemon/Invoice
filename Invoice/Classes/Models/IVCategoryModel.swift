//
//  IVCategoryModel.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVCategoryModel: NSObject {
        
        var identifier: String?
        var type: String?
        var companyId: String?
        var name: String?
        var createdDate: String?
        var updatedDate: String?
        
        convenience init(withInformation information:[String : Any?]) {
            
            self.init()
            self.identifier = information["_id"] as? String
            self.type = information["type"] as? String
            self.companyId = information["companyId"] as? String
            self.name = information["name"] as? String
            self.updatedDate = information["updatedAt"] as? String
            self.createdDate = information["createdAt"] as? String
            
        }
        
}

