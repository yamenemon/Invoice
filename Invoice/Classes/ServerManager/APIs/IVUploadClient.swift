//
//  IVUploadClient.swift
//  Invoice
//
//  Created by Scrupulous on 28/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVUploadClient: NSObject {
    
    open class func getRequestBuilderForURLofUploadFile(withFolderName folderName:String, withFileName fileName:String) -> RequestBuilder< [String : Any] >
    {
        let path = IVAPIHelper.getPath(type:IVAPIType.upload)
        let URLString = IVClientAPI.basePath + path + "\(folderName)/" + fileName
        let nillableParameters: [String:Any?] = [ : ]
        let parameters = IVAPIHelper.rejectNil(nillableParameters)
        let convertedParameters = IVAPIHelper.convertBoolToString(parameters)
        let requestBuilder: RequestBuilder<[String : Any]>.Type = IVClientAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
        
    }


}
