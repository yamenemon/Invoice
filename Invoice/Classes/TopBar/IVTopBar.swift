//
//  IVTopBar.swift
//  Invoice
//
//  Created by Scrupulous on 8/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

protocol IVTopBarDelegate : NSObjectProtocol {
    
    func didPressedSearch(withSearch key: String)
    func didCancelSearchMode()
    
}

class IVTopBar: IVXibView {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet var widthConstraintOfSearchButton : NSLayoutConstraint!
    @IBOutlet var widthConstraintOfDownloadButton : NSLayoutConstraint!
    @IBOutlet var widthConstraintOfShortButton : NSLayoutConstraint!
    @IBOutlet var widthConstraintOfMoreButton : NSLayoutConstraint!
    
    var selectedType : IVControllerType = .home
    var delegate : IVTopBarDelegate?

    func initializeAppreance(type:IVControllerType) {
        self.resetAppearance()
        switch type {
        case .home:
            self.lblTitle.text = "Home"
        case .invoice:
            self.lblTitle.text = "Invoice"
            self.widthConstraintOfSearchButton.constant = 40
            self.widthConstraintOfShortButton.constant = 40
        case .addInvoice:
            self.lblTitle.text = "Add Invoice"
        case .vendor:
            self.lblTitle.text = "Vendor"
        case .report:
            self.lblTitle.text = "Report"
            self.widthConstraintOfSearchButton.constant = 40
            self.widthConstraintOfDownloadButton.constant = 40
            self.widthConstraintOfShortButton.constant = 40
            self.widthConstraintOfMoreButton.constant = 40
        }
      
    }
    
    func resetAppearance() {
        self.searchBar.isHidden = true
        self.widthConstraintOfSearchButton.constant = 0
        self.widthConstraintOfDownloadButton.constant = 0
        self.widthConstraintOfShortButton.constant = 0
        self.widthConstraintOfMoreButton.constant = 0
        
        self.searchBar.barTintColor = UIColor.clear
        self.searchBar.backgroundColor = UIColor.clear
        self.searchBar.isTranslucent = true
        self.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
  
    
    @IBAction func btnSearchAction(sender: UIButton) {
        
        if self.searchBar.isHidden == true {
            self.lblTitle.text = ""
            if self.selectedType == .invoice {
                self.searchBar.placeholder = "Type invoice..."
            } else if self.selectedType == .report {
                self.searchBar.placeholder = "Type report..."
            }
            self.searchBar.isHidden = false
            self.searchBar.delegate = self
            self.searchBar.becomeFirstResponder()
        } else {
            self.searchBar.resignFirstResponder()
            self.initializeAppreance(type: self.selectedType)
            self.delegate?.didCancelSearchMode()
        }
        
    }
    
    func hideSearchBar(){
        
        self.searchBar.resignFirstResponder()
        self.initializeAppreance(type: self.selectedType)
        
    }

}

extension IVTopBar : UISearchBarDelegate {
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchKey = self.searchBar.text
        self.delegate?.didPressedSearch(withSearch: searchKey!)
        self.searchBar.resignFirstResponder()
        
    }
    
}
