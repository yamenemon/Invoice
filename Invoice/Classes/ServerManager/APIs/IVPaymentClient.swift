//
//  IVPaymentClient.swift
//  Invoice
//
//  Created by Scrupulous on 11/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVPaymentClient: NSObject {
    
    open class func getRequestBuilderForPaymentMethods() -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.paymentMethods)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [:]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
    
    open class func getRequestBuilderForPaymentMethodsdetails(withPaymentID paymentID:String) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.paymentMethods)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [
            "id" : paymentID
        ]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}
