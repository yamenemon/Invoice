//
//  UIViewController+Extension.swift
//  Invoice
//
//  Created by Scrupulous on 23/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

extension UIViewController {
    
    func checkPhotoLibraryPermission(completionHandler:@escaping (Bool)->() ) {
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completionHandler(true)
        case .denied, .restricted :
            self.alertToEncouragePhotoLibraryAccessInitially()
            completionHandler(false)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        completionHandler(true)
                    case .denied, .restricted:
                        completionHandler(false)
                    case .notDetermined:
                        completionHandler(false)
                    }
                }
                
            }
        }
        
    }
    
    func alertToEncouragePhotoLibraryAccessInitially() {
        let alert = UIAlertController(
            title: "Photo library",
            message: "Invoice app wants to access the photo library.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Allow library", style: .default, handler: { (alert) -> Void in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    func checkCameraPermission(completionHandler:@escaping (Bool)->() ) {
        
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .authorized: completionHandler(true)
        case .denied:
            self.alertToEncourageCameraAccessInitially()
            completionHandler(false)
        case .notDetermined:
            
            AVCaptureDevice.requestAccess(for: .video) { success in
                
                DispatchQueue.main.async {
                    if success {
                        completionHandler(true)
                    } else {
                        completionHandler(false)
                    }
                }
                
            }
            
        default:
            self.alertToEncourageCameraAccessInitially()
            completionHandler(false)
        }
        
    }
    
    func alertToEncourageCameraAccessInitially() {
        let alert = UIAlertController(
            title: "Camera",
            message: "Invoice app wants to access the camera.",
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: "Allow Camera", style: .default, handler: { (alert) -> Void in
            
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}

