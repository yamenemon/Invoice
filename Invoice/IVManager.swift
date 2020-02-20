//
//  IVManager.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVManager: NSObject {
    
    var token : String?
    var vendors = [IVVendorModel]()
    var paymentMethods = [IVPaymentModel]()
    var categories = [IVCategoryModel]()
    
    static let shared = IVManager()
    private override init() { }
    
    func setAuthorizationToken(token:String?) {
        self.token = token
    }

}
