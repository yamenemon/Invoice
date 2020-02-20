//
//  IVBottomBarItem.swift
//  Invoice
//
//  Created by Scrupulous on 22/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVBottomBarItem: IVXibView {

    @IBOutlet weak var iconContainer : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    var type : IVControllerType?
    var isSelected : Bool = false
    
    func initializeContainer(type:IVControllerType) {
        self.type = type
        
        self.lblTitle.textColor = UIColor.init(hexString: "142B77", alpha: 1.0)
        
        switch self.type! {
        case .home:
            let origImage = UIImage(named: "baseline_dashboard")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconContainer.image = tintedImage
            iconContainer.tintColor = UIColor.init(hexString: "142B77", alpha: 1.0)
            
            self.lblTitle.text = "Home"
            
        case .invoice:
            let origImage = UIImage(named: "baseline_receipt")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconContainer.image = tintedImage
            iconContainer.tintColor = UIColor.init(hexString: "142B77", alpha: 1.0)
            
            self.lblTitle.text = "Invoice"
            
        case .addInvoice:
            let origImage = UIImage(named: "baseline_dashboard")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconContainer.image = tintedImage
            iconContainer.tintColor = UIColor.init(hexString: "142B77", alpha: 1.0)
            
            self.lblTitle.text = "Add"
            
        case .vendor:
            let origImage = UIImage(named: "baseline_people")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconContainer.image = tintedImage
            iconContainer.tintColor = UIColor.init(hexString: "142B77", alpha: 1.0)
            
            self.lblTitle.text = "Vendor"
            
        case .report:
            let origImage = UIImage(named: "baseline_report")
            let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
            iconContainer.image = tintedImage
            iconContainer.tintColor = UIColor.init(hexString: "142B77", alpha: 1.0)
            
            self.lblTitle.text = "Report"
       
        }
     
        self.updateselectionStatus()
    }
    
    func updateselectionStatus() {
        
        if self.isSelected == true {
            self.alpha = 1.0
        } else {
            self.alpha = 0.5
        }
        
    }
    
    
}
