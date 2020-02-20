//
//  IVAddInvoiceCell3.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

class IVAddInvoiceCell3: UITableViewCell {

    @IBOutlet weak var imageContainer:UIImageView!
  
    var selectedInformation : IVInputModel?
    var showImagePickerHandler : ((Bool) -> Void)?
    var saveActionHandler : ((Bool) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setInformation(information:IVInputModel?) {
        self.selectedInformation = information
        if let inputInfo = self.selectedInformation {
          
            
        }
    }
    
    @IBAction func btnImagePickerAction(_ sender: Any) {
       self.showImagePickerHandler?(true)
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        self.saveActionHandler?(true)
    }
    
}
