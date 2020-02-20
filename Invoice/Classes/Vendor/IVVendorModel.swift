//
//  IVVendorModel.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVVendorModel: NSObject {
    
    var email: String?
    var name: String?
    var identifier: String?
    var address: String?
    var createdDate: String?
    var updatedDate: String?
    var imageUrl: String?
   
    convenience init(withInformation information:[String : Any?]) {
        
        self.init()
        
        self.updatedDate = information["updatedAt"] as? String
        self.email = information["email"] as? String
        self.name = information["name"] as? String
        self.identifier = information["_id"] as? String
        self.address = information["address"] as? String
        self.createdDate = information["createdAt"] as? String
        self.imageUrl = information["imageUrl"] as? String
       
    }


}
