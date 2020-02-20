//
//  IVBottomBar.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

enum IVControllerType : Int {
    case home = 0
    case invoice
    case addInvoice
    case vendor
    case report
}

protocol IVBottomBarDelegate : NSObjectProtocol {
    
    func didSelectedController(withType type: IVControllerType)
    
}

class IVBottomBar: IVXibView {

    var delegate : IVBottomBarDelegate?
    
    @IBOutlet weak var homeItem : IVBottomBarItem!
    @IBOutlet weak var invoiceItem : IVBottomBarItem!
    @IBOutlet weak var addInvoiceItem : IVBottomBarItem!
    @IBOutlet weak var vendorItem : IVBottomBarItem!
    @IBOutlet weak var reportItem : IVBottomBarItem!
    
    func initializeContainer() {
        homeItem.isSelected = true
        homeItem.initializeContainer(type: .home)
        invoiceItem.initializeContainer(type: .invoice)
        addInvoiceItem.initializeContainer(type: .addInvoice)
        vendorItem.initializeContainer(type: .vendor)
        reportItem.initializeContainer(type: .report)
    }
    
    func updateSelectionStatus() {
        
          homeItem.updateselectionStatus()
          invoiceItem.updateselectionStatus()
          addInvoiceItem.updateselectionStatus()
          vendorItem.updateselectionStatus()
          reportItem.updateselectionStatus()
        
    }
    
    
    @IBAction func btnHomeAction(sender: UIButton) {
        homeItem.isSelected = true
        invoiceItem.isSelected = false
        addInvoiceItem.isSelected = false
        vendorItem.isSelected = false
        reportItem.isSelected = false
        self.updateSelectionStatus()
        self.delegate?.didSelectedController(withType: .home)
    }
    
    @IBAction func btnInvoiceAction(sender: UIButton) {
        homeItem.isSelected = false
        invoiceItem.isSelected = true
        addInvoiceItem.isSelected = false
        vendorItem.isSelected = false
        reportItem.isSelected = false
        self.updateSelectionStatus()
        self.delegate?.didSelectedController(withType: .invoice)
    }
    
    @IBAction func btnAddInvoiceAction(sender: UIButton) {
        homeItem.isSelected = false
        invoiceItem.isSelected = false
        addInvoiceItem.isSelected = true
        vendorItem.isSelected = false
        reportItem.isSelected = false
        self.updateSelectionStatus()
        self.delegate?.didSelectedController(withType: .addInvoice)
    }
    
    @IBAction func btnVendorAction(sender: UIButton) {
        homeItem.isSelected = false
        invoiceItem.isSelected = false
        addInvoiceItem.isSelected = false
        vendorItem.isSelected = true
        reportItem.isSelected = false
        self.updateSelectionStatus()
        self.delegate?.didSelectedController(withType: .vendor)
    }
    
    @IBAction func btnReportAction(sender: UIButton) {
        homeItem.isSelected = false
        invoiceItem.isSelected = false
        addInvoiceItem.isSelected = false
        vendorItem.isSelected = false
        reportItem.isSelected = true
        self.updateSelectionStatus()
        self.delegate?.didSelectedController(withType: .report)
    }
    

}
