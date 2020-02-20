//
//  IVReportViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVReportViewController: UIViewController {

    @IBOutlet weak var reportController:UITableView!
    
    var reports = [IVReportModel]()
    
    class func initWithStoryboard() -> IVReportViewController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "IVReportViewController") as! IVReportViewController
        return controller
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeContainer()
        self.getReportList()
    }
    
    func initializeContainer() {
        
        self.reportController.register(UINib(nibName: "IVReportCell", bundle:nil), forCellReuseIdentifier: "IVReportCell")
        self.reportController.separatorStyle = .none
        self.reportController.estimatedRowHeight = 44
        self.reportController.rowHeight = UITableView.automaticDimension
        self.reportController.reloadData()
    }
    
    func getReportList() {
        
        let vendorBuilder = IVVendorClient.getRequestBuilderForVendors()
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let vendorItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                    for item in vendorItems {
                        
                        let vendor = IVReportModel.init(withInformation: item)
                        self.reports.append(vendor)
                        
                    }
                    
                    self.reportController.reloadData()
                    
                }
                
            }
            
        }
    }
}

extension IVReportViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IVReportCell", for: indexPath) as! IVReportCell
        let report = self.reports[indexPath.row]
        cell.setInformationOnView(withItem: report)
        return cell
    }
    
}

extension IVReportViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
    }
    
}


