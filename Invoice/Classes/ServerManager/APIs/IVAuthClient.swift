//
//  SCAuthClient.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVAuthClient: NSObject {
    
    open class func getRequestBuilderForRegisterUser(withUserName userName:String?, withPassword password:String?) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.register)
        let URLString = IVClientAPI.basePath + path
        
        let nillableParameters: [String:Any?] = [
            "username": userName,
            "password": password
        ]
        
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    open class func getRequestBuilderForLogInUser(withUserName userName:String?, withPassword password:String?) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.login)
        let URLString = IVClientAPI.basePath + path
        
        let nillableParameters: [String:Any?] = [
            "username": userName,
            "password": password
        ]
        
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }
    
    open class func getRequestBuilderForMeInformatiom() -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.me)
        let URLString = IVClientAPI.basePath + path
        let nillableParameters: [String:Any?] = [:]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }
    
 
}
