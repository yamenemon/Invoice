//
//  IVInvoiceCell.swift
//  Invoice
//
//  Created by Scrupulous on 7/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import SDWebImage

class IVInvoiceCell: UITableViewCell {

    @IBOutlet weak var iconContainer:UIImageView!
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblNote:UILabel!
    @IBOutlet weak var lblCategory:UILabel!
    @IBOutlet weak var lblPaymentMethod:UILabel!
    @IBOutlet weak var lblPaymentDate:UILabel!
    @IBOutlet weak var lblAmount:UILabel!
    
    var selectedItem : IVInvoiceModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInformationOnView(withItem item:IVInvoiceModel?) {
        
        self.selectedItem = item
        if let invoice = self.selectedItem {
            
            if let title = invoice.title {
                self.lblTitle.text = title
            }
            
            if let note = invoice.note {
                self.lblNote.text = note
            }
            
            if let category = invoice.category {
                self.lblCategory.text = "Category: \(category)"
            }
            
            if let paymentMethod = invoice.paymentMethod {
                self.lblPaymentMethod.text = "Payment method: \(paymentMethod)"
            }
            
            if let paymentDate = invoice.paidDate {
                self.lblPaymentDate.text = paymentDate
            }
            
            if let amount = invoice.amount {
                self.lblAmount.text = "$\(amount)"
            }
         
            if let iconURL = invoice.imageUrl {
                self.iconContainer.sd_setImage(with: URL(string: iconURL), placeholderImage: nil)
            }

        }
        
    }
    
}
