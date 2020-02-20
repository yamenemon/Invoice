//
//  IVExpencesCell2.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import CSPieChart

class IVExpencesCell2: IVExpencesCell1 {
    
    @IBOutlet weak var lblExpences: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override func setInformation(information:CSPieChartData?, color:UIColor) {
       self.lblName.textColor = color
       super.setInformation(information: information, color: color)
        if let selectedInfo = self.selectedItem {
            self.lblExpences.text = "\(Int(selectedInfo.value))"
        }
        
    }
    
}
