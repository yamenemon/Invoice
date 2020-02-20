//
//  UITextField+Extension.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func keepTextFieldAboveKeyboard(tableView:UITableView, bottomPadding:CGFloat) {
        
        var willShowNotification: NSObjectProtocol?
        var willHideNotification: NSObjectProtocol?
        
        willShowNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) {(notification) in
            
            var userInfo = notification.userInfo!
            
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                // Get my height size
                let myheight = tableView.frame.height
                // Get the top Y point where the keyboard will finish on the view
                let keyboardEndPoint = myheight - keyboardFrame.height
                // Get the the bottom Y point of the textInput and transform it to the currentView coordinates.
                if let pointInTable = self.superview?.convert(self.frame.origin, to: tableView) {
                    
                    let textFieldBottomPoint = pointInTable.y + self.frame.size.height + 20 - bottomPadding
                    
                    // Finally check if the keyboard will cover the textInput
                    if keyboardEndPoint <= textFieldBottomPoint {
                        
                        tableView.contentOffset.y = textFieldBottomPoint - keyboardEndPoint
                    } else {
                        
                        tableView.contentOffset.y = 0
                    }
                }
            }
            
            NotificationCenter.default.removeObserver(willShowNotification!)
        }
        
        willHideNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { (notification) in
            
            tableView.contentOffset.y = 0
            NotificationCenter.default.removeObserver(willHideNotification!)
            
        }
        
    }
    
    func updateTextFieldAboveKeyboard(tableView:UITableView, bottomPadding:CGFloat) {
        
        // Get my height size
        let myheight = tableView.frame.height
        // Get the top Y point where the keyboard will finish on the view
        let keyboardEndPoint = myheight - 216
        // Get the the bottom Y point of the textInput and transform it to the currentView coordinates.
        if let pointInTable = self.superview?.convert(self.frame.origin, to: tableView) {
            
            let textFieldBottomPoint = pointInTable.y + self.frame.size.height + 20 - bottomPadding
            
            // Finally check if the keyboard will cover the textInput
            if keyboardEndPoint <= textFieldBottomPoint {
                
                tableView.contentOffset.y = textFieldBottomPoint - keyboardEndPoint
            } else {
                
                tableView.contentOffset.y = 0
            }
        }
        
        
        
    }
    
    func keepTextFieldAboveKeyboard(view:UIView, bottomPadding:CGFloat) {
        
        var willShowNotification: NSObjectProtocol?
        var willHideNotification: NSObjectProtocol?
        
        willShowNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) {(notification) in
            
            var userInfo = notification.userInfo!
            
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                // Get my height size
                let myheight = view.frame.height
                // Get the top Y point where the keyboard will finish on the view
                let keyboardEndPoint = myheight - keyboardFrame.height
                // Get the the bottom Y point of the textInput and transform it to the currentView coordinates.
                if let pointInTable = self.superview?.convert(self.frame.origin, to: view) {
                    
                    let textFieldBottomPoint = pointInTable.y + self.frame.size.height + 20 - bottomPadding
                    
                    // Finally check if the keyboard will cover the textInput
                    if keyboardEndPoint <= textFieldBottomPoint {
                        //                            view.frame.y = textFieldBottomPoint - keyboardEndPoint
                    } else {
                        //                            view.contentOffset.y = 0
                    }
                }
            }
            
            NotificationCenter.default.removeObserver(willShowNotification!)
        }
        
        willHideNotification = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { (notification) in
            
            //                view.contentOffset.y = 0
            NotificationCenter.default.removeObserver(willHideNotification!)
            
        }
        
    }
    
}
