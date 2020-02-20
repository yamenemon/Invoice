//
//  IVClientAPI.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

let SERVER_URL = "http://ec2-54-87-132-38.compute-1.amazonaws.com:3000"

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class IVClientAPI {

    public static var basePath = SERVER_URL
    public static var credential: URLCredential?
    public static var customHeaders: [String:String] = [:]
    static var requestBuilderFactory: RequestBuilderFactory = AlamofireRequestBuilderFactory()
}

open class RequestBuilder<T> {
    var credential: URLCredential?
    var headers: [String:String] = [:]
    let parameters: [String:Any]?
    let isBody: Bool
    let method: String
    var URLString: String
    var cachePolicy: NSURLRequest.CachePolicy?
    
    /// Optional block to obtain a reference to the request's progress instance when available.
    public var onProgressReady: ((Progress) -> ())?
    
    required public init(method: String, URLString: String, parameters: [String:Any]?, isBody: Bool) {
        self.method = method
        self.URLString = URLString
        self.parameters = parameters
        self.isBody = isBody
        
        addHeaders(IVClientAPI.customHeaders)
        
        let token : String? = IVManager.shared.token
        if let authToken = token, authToken.count > 0 {
            //self.headers = [ "Authorization" : "Bearer \(authToken)" ]
            
            self.headers = [ "x-access-token" : "\(authToken)" ]
        }

        
    }
    
    open func addHeaders(_ aHeaders:[String:String]) {
        for (header, value) in aHeaders {
            headers[header] = value
        }
    }
    
    open func execute(_ completion: @escaping (_ response: Response<T>?, _ error: Error?) -> Void) { }
    
    public func addHeader(name: String, value: String) -> Self {
        if !value.isEmpty {
            headers[name] = value
        }
        return self
    }
    
    open func addCredential() -> Self {
        self.credential = IVClientAPI.credential
        return self
    }
    
    open func addCachePolicy(_ cachePolicy: NSURLRequest.CachePolicy) -> Self {
        self.cachePolicy = cachePolicy
        return self
    }
}

open class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T?
    
    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }
    
    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()
    
    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }
    
    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }
    
    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }
    
    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }
    
    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }
        
        let key = "\(T.self)"
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }
    
    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }
    
    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }
    
    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }
    
    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd HH:mm:ss"
            ].map { (format: String) -> DateFormatter in
                let formatter = DateFormatter()
                formatter.dateFormat = format
                formatter.locale = Locale(identifier: "en_US_POSIX")
                return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
            if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int64 {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        }
        
    }()
    
    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
        
public protocol RequestBuilderFactory {
    func getBuilder<T>() -> RequestBuilder<T>.Type
}
