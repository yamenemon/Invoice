//
//  VSUploadItem.swift
//  Invoice
//
//  Created by Scrupulous on 8/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

enum VSUploadState {
    case new, upload, uploaded, failed
}

class VSUploadItem: NSObject {

    let name: String
    var url: URL?
    var state = VSUploadState.new
    var image : UIImage?
    
    init(withName name:String, withUrl url:URL?, withImage image:UIImage?) {
        self.name = name
        self.url = url
        self.image = image
    }
    
}
