//
//  IVInvoiceModel.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVInvoiceModel: NSObject {
    
    var paymentMethod: String?
    var invoiceNumber: Int?
    var identifier: String?
    var title: String?
    var imageUrl : String?
    var companyId : String?
    var vat : Int?
    var note : String?
    var category : String?
    var amount : Int?
    var createdDate: String?
    var updatedDate: String?
    var paidDate: String?
    var userId: String?
    var vendor: String?
    
    
    convenience init(withInformation information:[String : Any?]) {
        
        self.init()
        
        self.identifier = information["_id"] as? String
        self.userId = information["userId"] as? String
        self.title = information["title"] as? String
        
        self.imageUrl = information["imageUrl"] as? String
        self.companyId = information["companyId"] as? String
        self.vendor = information["vendor"] as? String
        
        self.note = information["note"] as? String
        self.category = information["category"] as? String
        self.updatedDate = information["updatedAt"] as? String
        self.createdDate = information["createdAt"] as? String
       
        self.amount = information["amount"] as? Int
        self.vat = information["vat"] as? Int
        
        self.paidDate = information["paidAt"] as? String
        self.paymentMethod = information["paymentMethod"] as? String
        self.invoiceNumber = information["invoiceNumber"] as? Int
       
       
    }


}
