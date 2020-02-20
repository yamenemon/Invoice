//
//  IVAddInvoiceViewController.swift
//  Invoice
//
//  Created by Scrupulous on 4/9/19.
//  Copyright © 2019 Md. Mamun-Ur-Rashid. All rights reserved.
//

import UIKit
import Photos

class IVAddInvoiceViewController: UIViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    @IBOutlet weak var pickerContainer: UIView!
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var datePickerContainer: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var options = [IVInputModel]()
    var selectedInputInformation : IVInputModel?
    
     var imagePicker = UIImagePickerController()

    class func initWithStoryboard() -> IVAddInvoiceViewController {
        
        let storyboard  = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "IVAddInvoiceViewController") as! IVAddInvoiceViewController
        return controller ;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.delegate = self
        self.imagePicker.modalPresentationStyle = .overCurrentContext
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        self.options.append(IVInputModel.init(withInputType: .title, withOptionType: .text, withValue: nil, withPlaceholder: "Title"))
        self.options.append(IVInputModel.init(withInputType: .amount, withOptionType: .text, withValue: nil, withPlaceholder: "Amount"))
        self.options.append(IVInputModel.init(withInputType: .date, withOptionType: .picker, withValue: nil, withPlaceholder: "Date"))
        self.options.append(IVInputModel.init(withInputType: .category, withOptionType: .picker, withValue: nil, withPlaceholder: "Category"))
        self.options.append(IVInputModel.init(withInputType: .vendor, withOptionType: .picker, withValue: nil, withPlaceholder: "Vendor"))
        self.options.append(IVInputModel.init(withInputType: .payment, withOptionType: .picker, withValue: nil, withPlaceholder: "Payment"))
        self.options.append(IVInputModel.init(withInputType: .note, withOptionType: .text, withValue: nil, withPlaceholder: "Note"))
         self.options.append(IVInputModel.init(withInputType: .image, withOptionType: .file, withValue: nil, withPlaceholder: "Image"))
        self.initializeContainer()
    }
    
    
   
    
    
    func initializeContainer() {
        
        self.tableView.register(UINib(nibName: "IVAddInvoiceCell", bundle:nil), forCellReuseIdentifier: "IVAddInvoiceCell")
        self.tableView.register(UINib(nibName: "IVAddInvoiceCell2", bundle:nil), forCellReuseIdentifier: "IVAddInvoiceCell2")
        self.tableView.register(UINib(nibName: "IVAddInvoiceCell3", bundle:nil), forCellReuseIdentifier: "IVAddInvoiceCell3")
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.reloadData()
    }
    
    func getInformationFor(type:VSInputType) -> IVInputModel {
        
        var selectedItem : IVInputModel? = nil
        for item in self.options {
            if item.inputType == type {
                selectedItem = item
                break
            }
        }
        return selectedItem!
        
    }
    
    
    func showImagePicker() {
        
        self.checkPhotoLibraryPermission { [weak self] (status) in
            
            guard let weakSelf = self else {
                return
            }
            
            if status == true {
                
                weakSelf.imagePicker.sourceType = .photoLibrary
                weakSelf.present(weakSelf.imagePicker, animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    
    @IBAction func btnPickerCancelAction(_ sender: Any) {
        
        if self.selectedInputInformation?.inputType == .date {
           
            self.datePickerContainer.isHidden = true
            
        } else {
        
            self.pickerContainer.isHidden = true
            
        }
        
    }
    
    @IBAction func btnPickerDoneAction(_ sender: Any) {
        
        if self.selectedInputInformation?.inputType == .date {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: self.datePicker.date)
            self.selectedInputInformation?.inputValue = selectedDate
            
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 2, section: 0)) as! IVAddInvoiceCell2
            cell.inputField.text = selectedDate
            cell.updateNormalAppearance()
            
            self.datePickerContainer.isHidden = true
            
        } else if self.selectedInputInformation?.inputType == .payment {
            
            let paymentItem = IVManager.shared.paymentMethods[self.picker.selectedRow(inComponent: 0)]
            self.selectedInputInformation?.inputValue = paymentItem
            
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 5, section: 0)) as! IVAddInvoiceCell2
            cell.inputField.text = paymentItem.name
            cell.updateNormalAppearance()
            
            self.pickerContainer.isHidden = true
            
        }  else if self.selectedInputInformation?.inputType == .category {
            
            let categoryItem = IVManager.shared.categories[self.picker.selectedRow(inComponent: 0)]
            self.selectedInputInformation?.inputValue = categoryItem
            
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 3, section: 0)) as! IVAddInvoiceCell2
            cell.inputField.text = categoryItem.name
            cell.updateNormalAppearance()
            
            self.pickerContainer.isHidden = true
            
        } else if self.selectedInputInformation?.inputType == .vendor {
            
            let vendorItem = IVManager.shared.vendors[self.picker.selectedRow(inComponent: 0)]
            self.selectedInputInformation?.inputValue = vendorItem
            
            let cell = self.tableView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as! IVAddInvoiceCell2
            cell.inputField.text = vendorItem.name
            cell.updateNormalAppearance()
            
            self.pickerContainer.isHidden = true
            
        } else {
            
            self.pickerContainer.isHidden = true
            
        }
        
    }
    

}

extension IVAddInvoiceViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return self.options.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let selectedItem = self.options[indexPath.item]
        
        if selectedItem.inputType == .title || selectedItem.inputType == .amount || selectedItem.inputType == .note {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "IVAddInvoiceCell", for: indexPath) as! IVAddInvoiceCell
            cell.inputField.delegate = self
            cell.inputField.tag = indexPath.row
            cell.setInformation(information: selectedItem)
            return cell
            
        } else  if selectedItem.inputType == .image {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "IVAddInvoiceCell3", for: indexPath) as! IVAddInvoiceCell3
            
            cell.showImagePickerHandler = { [weak self] (isShow) in
                
                guard let weakSelf = self else {
                    return
                }
                
               weakSelf.showImagePicker()
                
            }
            
            cell.saveActionHandler = { [weak self] (isSave) in
                
                guard let weakSelf = self else {
                    return
                }
                
               
                
            }
            
            cell.setInformation(information: selectedItem)
            
            return cell
            
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "IVAddInvoiceCell2", for: indexPath) as! IVAddInvoiceCell2
            cell.setInformation(information: selectedItem)
            cell.showPickerHandler = { [weak self] (selectedItem) in
                
                guard let weakSelf = self else {
                    return
                }
                
                weakSelf.selectedInputInformation = selectedItem
                
                
                if selectedItem?.inputType == .date {
                    
                    weakSelf.datePickerContainer.isHidden = false
                    
                } else {
                    
                    weakSelf.pickerContainer.isHidden = false
                    weakSelf.picker.reloadAllComponents()
                    
                }
                
                
            }
            return cell
            
        }
        
        
       
    }
    
}

extension IVAddInvoiceViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
    }
    
}

extension IVAddInvoiceViewController : UITextFieldDelegate {
    
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
        
        guard let tableView = textField.parentView(of: UITableView.self) else { return true }
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: textField.tag, section: 0)) as! IVAddInvoiceCell
        cell.updateEditAppearance()
        
        textField.keepTextFieldAboveKeyboard(tableView:tableView, bottomPadding: 60);
        return true;
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(textField.text!)
        let cell = tableView.cellForRow(at: IndexPath.init(row: textField.tag, section: 0)) as! IVAddInvoiceCell
        cell.updateNormalAppearance()
       
        return true
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            let selectedItem = self.options[textField.tag]
            selectedItem.inputValue = updatedText
            
        }
        return true
        
    }
    
    
}


extension IVAddInvoiceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        guard let image = originalImage else {
            print("Can't analyze selected photo")
            return
        }
        
        let cell = tableView.cellForRow(at: IndexPath.init(row: self.options.count-1, section: 0)) as! IVAddInvoiceCell3
        cell.selectedInformation?.inputValue = image
        cell.imageContainer.image = image
        dismiss(animated: true, completion: nil)
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension IVAddInvoiceViewController: UIPickerViewDataSource {
    
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.selectedInputInformation?.inputType == .payment {
            return IVManager.shared.paymentMethods.count
        } else if self.selectedInputInformation?.inputType == .category {
            return IVManager.shared.categories.count
        } else if self.selectedInputInformation?.inputType == .vendor {
            return IVManager.shared.vendors.count
        } else {
            return 10
        }
        
      
    }
    
}

extension IVAddInvoiceViewController: UIPickerViewDelegate {
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 44.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.selectedInputInformation?.inputType == .payment {
            
            let paymentItem = IVManager.shared.paymentMethods[row]
            return paymentItem.name
            
        } else if self.selectedInputInformation?.inputType == .category {
            
            let categoryItem = IVManager.shared.categories[row]
            return categoryItem.name
            
        } else if self.selectedInputInformation?.inputType == .vendor {
            
            let vendorItem = IVManager.shared.vendors[row]
            return vendorItem.name
            
        } else {
            return "Vendor"
        }
        
        
    }
    
}


