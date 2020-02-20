//
//  IVExpencesCell1.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import CSPieChart

class IVExpencesCell1: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var colorIndicator: UIView?

    var selectedItem : CSPieChartData?
    var selectedColor : UIColor = .clear
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setInformation(information:CSPieChartData?, color:UIColor) {
        self.selectedItem = information
        
        if let selectedInfo = self.selectedItem {
            self.lblName.text = selectedInfo.key
            
            if let indicator = self.colorIndicator {
                indicator.backgroundColor = color
            }
            
        }
    }
    
}
