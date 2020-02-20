//
//  IVInvoiceClient.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVInvoiceClient: NSObject {
    
    open class func getRequestBuilderForInvoices() -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.expenses)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [ : ]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }
    
    //type: 'daily' | 'weekly' | 'monthly' | 'yearly';

    open class func getRequestBuilderForExpensesStats(withType type:String) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.expensesStats)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [
            "type" : type
        ]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }
    
    //type: 'daily' | 'weekly' | 'monthly' | 'yearly';
    
    open class func getRequestBuilderForExpensesStatsByCategory(withType type:String) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.expensesStatsByCategory)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [
            "type" : type
        ]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }
    
    
   


}
