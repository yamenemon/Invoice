//
//  IVAPIHelper.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//


import UIKit


enum IVAPIType {
    
    case register
    case login
    case categories
    case vendors
    case companies
    case paymentMethods
    case me
    case expenses
    case expensesStats
    case expensesStatsByCategory
    case upload
  
}



class IVAPIHelper {
    
   static func getPath(type:IVAPIType) -> String {
        
        switch type {
            
            case .register: return "/auth/register"
            case .login: return "/auth/login"
            case .categories: return "/categories"
            case .vendors: return "/vendors"
            case .companies: return "/companies"
            case .paymentMethods: return "/payment-methods/"
            case .me: return "/me"
            case .expenses: return "/expenses"
            case .expensesStats: return "/expenses/stats"
            case .expensesStatsByCategory: return "/expenses/stats/category"
            case .upload: return "/upload/"
       
        }
        
    }

    static func rejectNil(_ source: [String:Any?]) -> [String:Any]? {
        var destination = [String:Any]()
        for (key, nillableValue) in source {
            if let value: Any = nillableValue {
                destination[key] = value
            }
        }
        
        if destination.isEmpty {
            return nil
        }
        return destination
    }
    
    static func convertBoolToString(_ source: [String: Any]?) -> [String:Any]? {
        guard let source = source else {
            return nil
        }
        var destination = [String:Any]()
        let theTrue = NSNumber(value: true as Bool)
        let theFalse = NSNumber(value: false as Bool)
        for (key, value) in source {
            switch value {
            case let x where x as? NSNumber === theTrue || x as? NSNumber === theFalse:
                destination[key] = "\(value as! Bool)" as Any?
            default:
                destination[key] = value
            }
        }
        return destination
    }
}
