//
//  IVVendorCell.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import SDWebImage

class IVVendorCell: UITableViewCell {

    @IBOutlet weak var iconContainer:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var lblAddress:UILabel!
    
    var selectedItem : IVVendorModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInformationOnView(withItem item:IVVendorModel?) {
        
        self.selectedItem = item
        if let vendor = self.selectedItem {
            
            self.lblName.text = vendor.name
            self.lblEmail.text = vendor.email
            self.lblAddress.text = vendor.address
            if let iconURL = vendor.imageUrl {
                self.iconContainer.sd_setImage(with: URL(string: iconURL), placeholderImage: nil)
            }

        }
        
    }
    
}
