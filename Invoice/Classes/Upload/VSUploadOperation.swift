//
//  VSUploadOperation.swift
//  Invoice
//
//  Created by Scrupulous on 8/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//


import UIKit
import Alamofire

protocol VSUploadOperationDelegate : NSObjectProtocol {
    
    func didReceivedResponseFromServer(item: NSDictionary?)
    
}

class VSUploadOperation: Operation {

    let uploadItem: VSUploadItem
    weak var selectionDelegate : VSUploadOperationDelegate?
    let dispatchGroup = DispatchGroup()
    
    init(withItem item:VSUploadItem) {
        self.uploadItem = item
    }
    
    override func main () {
        
        if isCancelled {
            return
        }
        
        guard self.uploadItem.state == .new else {
            return
        }
        
        dispatchGroup.enter()

        var imageDataS : Data?
        
        if let data = uploadItem.image!.pngData() {
            imageDataS = data
        } else if let data = uploadItem.image!.jpegData(compressionQuality: 1.0) {
            imageDataS = data
        }

        guard let imageData = imageDataS else { return }
        
        self.uploadItem.state = .upload
        

        self.getUploadURLFromServer(withFolderName: "expenses", withFileName: self.uploadItem.name) { (response, error) in
            
            DispatchQueue.main.sync {
                  self.myImageUploadRequest(withFileInformation: response, withData: imageData)
            }
            
          
          
        }
       
        dispatchGroup.wait()
        
        if isCancelled {
            return
        }
        
    }
    
    func cancelUploadOperation() {
        dispatchGroup.leave()
    }
    
    func leaveGroup() {
        dispatchGroup.leave()
    }
    

    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        var body = Data();
        
//        if parameters != nil {
//
//            for (key, value) in parameters! {
//                body.appendString(string:"--\(boundary)\r\n")
//                body.appendString(string:"Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//                body.appendString(string:"\(value)\r\n")
//            }
//        }
        
        let filename = parameters!["filename"]
        let mimetype = "image/jpg"
        
        body.appendString(string:"--\(boundary)\r\n")
        body.appendString(string:"Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string:"Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey)
        body.appendString(string:"\r\n")
        body.appendString(string:"--\(boundary)--\r\n")
        
        return body
       
        return body
        
    }
    
    func getUploadURLFromServer(withFolderName folderName:String, withFileName fileName:String, _ completion: @escaping (_ response: [String:String]?, _ error: Error?) -> Void) {
        
        let path = IVAPIHelper.getPath(type:IVAPIType.upload)
        let URLString = IVClientAPI.basePath + path + "\(folderName)/" + fileName
        
        var uploadUrl = URLComponents(string: URLString);
        uploadUrl!.queryItems = [
            URLQueryItem(name: "url", value: "image/jpeg")  // type: 'image/jpeg' | 'image/png'
        ]

        let request = NSMutableURLRequest.init(url: (uploadUrl?.url!)!)
        request.httpMethod = "GET"
      
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                completion(nil,error)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
               // print(json as Any)
                completion((json as! [String : String]),nil)
              
            } catch {
                 completion(nil,error)
            }
            
        }
        
        task.resume()
        
    }
    
    func myImageUploadRequest(withFileInformation info:[String:Any]?, withData data:Data)
    {
        
        var headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        
        let token : String? = IVManager.shared.token
        if let authToken = token, authToken.count > 0 {
           headers["x-access-token"] = authToken
        }
        
        let parameters = [String:String]()


        let uploadUrl = URLComponents(string: info!["url"] as! String);
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "image",fileName: info!["filename"] as! String, mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: uploadUrl!, method: .post, headers: headers) { (result) in
            
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print(response.result.value)
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
            
        }
        


        
        
//        uploadUrl!.queryItems = [
//            URLQueryItem(name: "url", value: "image/jpeg")  // type: 'image/jpeg' | 'image/png'
//        ]
//
//        let request = NSMutableURLRequest.init(url: (uploadUrl?.url!)!)
//        request.httpMethod = "PUT"
//
//        let param = [ "filename"  : info!["filename"] as! String ]
//
//
//        let token : String? = IVManager.shared.token
//        if let authToken = token, authToken.count > 0 {
//             request.addValue(authToken, forHTTPHeaderField: "x-access-token")
//        }
//
//        let boundary = generateBoundaryString()
//        //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//         request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
//
//        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "image", imageDataKey: data as Data, boundary: boundary) as Data
//
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//
//            if error != nil {
//                //self.selectionDelegate?.didReceivedResponseFromServer(item: nil)
//                return
//            }
//
//            do {
//
//                var backToString = String(data: data!, encoding: String.Encoding.utf8)
//
//                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? String
//                print(json as Any)
//              //  self.selectionDelegate?.didReceivedResponseFromServer(item: json)
//                self.leaveGroup()
//
//            } catch {
//              //  self.selectionDelegate?.didReceivedResponseFromServer(item: nil)
//            }
//
//        }
//
//        task.resume()
     }
    
}
