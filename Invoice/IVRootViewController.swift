//
//  IVRootViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit


class IVRootViewController: UIViewController {

    @IBOutlet weak var container : UIView!
    @IBOutlet weak var topBar : IVTopBar!
    @IBOutlet weak var bottomBar : IVBottomBar!
    
    var pageController : IVPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.delegate = self
        self.bottomBar.delegate = self
        self.bottomBar.initializeContainer()
        self.initializePages()
    }
    
    func initializePages() {
        
        self.pageController = IVPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.selectionDelegate = self
        
        if let controllers = self.pageController {
            
            let home = IVHomeViewController.initWithStoryboard()
            let invoice = IVInvoiceViewController.initWithStoryboard()
            let addInvoice = IVAddInvoiceViewController.initWithStoryboard()
            let vendor = IVVendorViewController.initWithStoryboard()
            let report = IVReportViewController.initWithStoryboard()
            controllers.setSubViewControllers(controllers: [home,invoice,addInvoice,vendor,report])
            controllers.view.frame = container.bounds
            addChild(controllers)
            container.addSubview(controllers.view)
            controllers.didMove(toParent: self)
            
        }
        self.pageController?.disableSwipeGesture()
        
//        let authClient = IVAuthClient.getRequestBuilderForRegisterUser(withUserName: "johny", withPassword: "johny")
//        authClient.execute { (response, error) in
//
//            if  let information = response?.body {
//
//                if let status = information["status"] as? String, status.count > 0 {
//
//
//
//                }
//
//            }
//
//        }
        
        
        let loginBuilder = IVAuthClient.getRequestBuilderForLogInUser(withUserName: "user", withPassword: "quickbook")
        loginBuilder.execute { (response, error) in

            if  let information = response?.body {

                if let token = information["token"] as? String, token.count > 0 {

                    IVManager.shared.setAuthorizationToken(token: token)
                    self.getVendors()
                    self.getPaymentMethods()
                    self.getUserInformation()
                    
                    
                    if let selectedController = self.pageController?.viewControllers?.first as? IVHomeViewController {
                        
                        selectedController.initializeServerCall()
                        
                    }
                    

                }

            }

        }

        
    }
    
    func getUserInformation() {
        
        let loginBuilder = IVAuthClient.getRequestBuilderForMeInformatiom()
        loginBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let token = information["token"] as? String, token.count > 0 {
                    
                    IVManager.shared.setAuthorizationToken(token: token)
                    
                    
                }
                
                if let categories = information["categories"] as? Array<Dictionary<String, Any>> {
                    IVManager.shared.categories.removeAll()
                    for item in categories {
                        
                        let category = IVCategoryModel.init(withInformation: item)
                        IVManager.shared.categories.append(category)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func getPaymentMethods() {
        
        let vendorBuilder = IVPaymentClient.getRequestBuilderForPaymentMethods()
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let paymentItems = information["results"] as? Array<Dictionary<String, Any>> {
                    IVManager.shared.paymentMethods.removeAll()
                    for item in paymentItems {
                        
                        let payment = IVPaymentModel.init(withInformation: item)
                        IVManager.shared.paymentMethods.append(payment)
                        
                    }
                    
                }
                
            }
            
        }
    }
    
    func getdetailsOfPaymentMethods(withPaymentID paymentId:String) {
        
        let vendorBuilder = IVPaymentClient.getRequestBuilderForPaymentMethodsdetails(withPaymentID: paymentId)
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let paymentItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                   
                    
                }
                
            }
            
        }
    }
    
    func getVendors() {
        
        let vendorBuilder = IVVendorClient.getRequestBuilderForVendors()
        vendorBuilder.execute { (response, error) in
            
            if  let information = response?.body {
                
                if let vendorItems = information["results"] as? Array<Dictionary<String, Any>> {
                    
                    for item in vendorItems {
                        
                        let vendor = IVVendorModel.init(withInformation: item)
                        IVManager.shared.vendors.append(vendor)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
   
    
//    func getCompanies() {
//
//        let vendorBuilder = IVCompanyClient.getRequestBuilderForCompanies()
//        vendorBuilder.execute { (response, error) in
//
//            if  let information = response?.body {
//
//                if let vendorItems = information["results"] as? Array<Dictionary<String, Any>> {
//
//
//
//                }
//
//            }
//
//        }
//    }
   
//    func getCategories() {
//
//        let vendorBuilder = IVCategoryClient.getRequestBuilderForCategories()
//        vendorBuilder.execute { (response, error) in
//
//            if  let information = response?.body {
//
//                if let token = information["results"] as? Array<Dictionary<String, Any>> {
//
//
//
//                }
//
//            }
//
//        }
//    }
   
}

extension IVRootViewController : IVBottomBarDelegate {
    
    func didSelectedController(withType type: IVControllerType) {
        
        self.pageController?.showViewController(at: type.rawValue)
        
    }
    
    
}

extension IVRootViewController : IVPageViewControllerDelegate {
    
    func didSelectedPageController(withType type: IVControllerType) {
        
        self.topBar.selectedType = type
        self.topBar.initializeAppreance(type: type)
        
    }
    
    
}

extension IVRootViewController : IVTopBarDelegate {
    
    func didPressedSearch(withSearch key: String) {
      
        if let selectedController = self.pageController?.viewControllers?.first as? IVInvoiceViewController {
            
            selectedController.searchItems(withSearch: key)
            
            
        }
        
    }
    
    func didCancelSearchMode() {
        
        if let selectedController = self.pageController?.viewControllers?.first as? IVInvoiceViewController {
            
            selectedController.didCancelSearchMode()
            
        }
        
    }
    
    
}

