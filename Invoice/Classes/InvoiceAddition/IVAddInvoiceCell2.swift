//
//  IVAddInvoiceCell2.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVAddInvoiceCell2: UITableViewCell {

    @IBOutlet weak var lblTopTitle:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var inputField:UITextField!
    @IBOutlet weak var container:UIView!
    
    var selectedInformation : IVInputModel?
    var showPickerHandler : ((IVInputModel?) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.container.layer.borderWidth = 1.0
        self.container.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setInformation(information:IVInputModel?) {
        self.selectedInformation = information
        if let inputInfo = self.selectedInformation {
            
            self.lblTopTitle.text = inputInfo.placeholderValue as! String
            self.lblTitle.text = inputInfo.placeholderValue as! String
            
        }
    }
    
    
    func updateEditAppearance()  {
        
        self.lblTopTitle.isHidden = false
        self.lblTitle.isHidden = true
        
    }
    
    func updateNormalAppearance()  {
        
        if self.inputField.text!.count > 0 {
            self.lblTopTitle.isHidden = false
            self.lblTitle.isHidden = true
        } else {
            self.lblTopTitle.isHidden = true
            self.lblTitle.isHidden = false
        }
        
    }
    
    @IBAction func btnPickerAction(_ sender: Any) {
        self.showPickerHandler?(self.selectedInformation)
    }
    
}
