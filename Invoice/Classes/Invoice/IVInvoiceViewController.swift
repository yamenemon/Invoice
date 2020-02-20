//
//  IVInvoiceViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import Alamofire

class IVInvoiceViewController: UIViewController {
    
    @IBOutlet weak var invoiceController:UITableView!
    
    var invoiceList = [IVInvoiceModel]()
    var searchInvoiceList = [IVInvoiceModel]()
    
    var isSearchEnable : Bool = false
   
    class func initWithStoryboard() -> IVInvoiceViewController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "IVInvoiceViewController") as! IVInvoiceViewController
        return controller
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeContainer()
        self.getInvoiceList()
        
       /*
        
        let picture = UIImage.init(named: "Food.jpg")
        var filename = ""  //UUID().uuidString
        filename.append(String.init(format: "_%.f.jpg",Date().timeIntervalSince1970 * 1000))
        let item = VSUploadItem.init(withName: filename, withUrl: nil, withImage: picture)
//        item.state = .new
//        let uploadOperation = VSUploadOperation.init(withItem: item)
//        uploadOperation.selectionDelegate = self
//        OperationQueue.main.addOperation(uploadOperation)
        
        var imageDataS : Data?
//        if let data = item.image!.pngData() {
//            imageDataS = data
//        } else
        if let data = item.image!.jpegData(compressionQuality: 1.0) {
            imageDataS = data
        }

        
        self.getUploadURLFromServer(withFolderName: "expenses", withFileName: item.name) { (response, error) in
            
            DispatchQueue.main.sync {
                self.myImageUploadRequest(withFileInformation: response, withData: imageDataS!)
            }
            
        
        }
 
       */
        
        
    }
    
    func myImageUploadRequest(withFileInformation info:[String:Any]?, withData data:Data)
    {
        
//        var headers: HTTPHeaders = [
//            "Content-type": "multipart/form-data"
//        ]
        
        var headers: HTTPHeaders = [ : ]
        
        let token : String? = IVManager.shared.token
        if let authToken = token, authToken.count > 0 {
            headers["x-access-token"] = authToken
        }
        
        let parameters = [String:String]()
        
        
        let uploadUrl = info!["url"] as! String
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: "image", mimeType: "image/jpeg")
            
         //   multipartFormData.append(data, withName: "image",fileName: info!["filename"] as! String, mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: uploadUrl, method: .put, headers: headers) { (result) in
            
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
    
    func initializeContainer() {
        
        self.invoiceController.register(UINib(nibName: "IVInvoiceCell", bundle:nil), forCellReuseIdentifier: "IVInvoiceCell")
        self.invoiceController.separatorStyle = .none
        self.invoiceController.estimatedRowHeight = 44
        self.invoiceController.rowHeight = UITableView.automaticDimension
        self.invoiceController.reloadData()
    }
    
    func getInvoiceList() {
        
        let vendorBuilder = IVInvoiceClient.getRequestBuilderForInvoices()
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let invoiceItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                    for item in invoiceItems {
                        
                        let invoice = IVInvoiceModel.init(withInformation: item)
                        self.invoiceList.append(invoice)
                        self.invoiceController.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    func searchItems(withSearch searchKey:String) {
        self.isSearchEnable = true
        self.invoiceController.reloadData()
    }
    
    func didCancelSearchMode() {
        self.isSearchEnable = false
        self.searchInvoiceList.removeAll()
        self.invoiceController.reloadData()
    }
    

}

extension IVInvoiceViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isSearchEnable == true {
            return self.searchInvoiceList.count
        } else {
            return self.invoiceList.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVInvoiceCell", for: indexPath) as! IVInvoiceCell
       
        if self.isSearchEnable == true {
            let invoice = self.searchInvoiceList[indexPath.row]
            cell.setInformationOnView(withItem: invoice)
        } else {
            let invoice = self.invoiceList[indexPath.row]
            cell.setInformationOnView(withItem: invoice)
        }
        
       
        return cell
    }
    
}

extension IVInvoiceViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
    }
    
}

extension IVInvoiceViewController: VSUploadOperationDelegate {
    
    func didReceivedResponseFromServer(item: NSDictionary?) {
        
        DispatchQueue.main.async {
            
         //   self.updateProfileImage(information: item as? Dictionary<String, Any>)
            
        }
    }
    
}

