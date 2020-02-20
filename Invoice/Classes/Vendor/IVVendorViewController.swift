//
//  IVVendorViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVVendorViewController: UIViewController {
    
    @IBOutlet weak var vendorsController:UITableView!
    
    var vendors = [IVVendorModel]()

    class func initWithStoryboard() -> IVVendorViewController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "IVVendorViewController") as! IVVendorViewController
        return controller
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeContainer()
        self.getVendors()
    }

    func initializeContainer() {
        
        self.vendorsController.register(UINib(nibName: "IVVendorCell", bundle:nil), forCellReuseIdentifier: "IVVendorCell")
        self.vendorsController.separatorStyle = .none
        self.vendorsController.estimatedRowHeight = 44
        self.vendorsController.rowHeight = UITableView.automaticDimension
        self.vendorsController.reloadData()
    }
    
    func getVendors() {
        
        let vendorBuilder = IVVendorClient.getRequestBuilderForVendors()
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let vendorItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                    for item in vendorItems {
                        
                        let vendor = IVVendorModel.init(withInformation: item)
                        self.vendors.append(vendor)
                        
                    }
                    
                    self.vendorsController.reloadData()
                    
                }
                
            }
            
        }
    }

}

extension IVVendorViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVVendorCell", for: indexPath) as! IVVendorCell
        let vendor = self.vendors[indexPath.row]
        cell.setInformationOnView(withItem: vendor)
        return cell
    }
    
}

extension IVVendorViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
 
        
    }
    
}
