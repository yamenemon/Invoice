//
//  IVVendorClient.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVVendorClient: NSObject {
    
    open class func getRequestBuilderForVendors() -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.vendors)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [:]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}
