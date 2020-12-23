//
//  Profile.swift
//  SPV
//
//  Created by HappySanz Tech on 08/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit
import SDWebImage

class Profile: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ProfileDetailsView {
    
    let presenter = ProfileDetailPresenter(profileDetailService:ProfileDetailService())
    var userData = [ProfileDetailsData]()
    
    /*Get User Update List*/
    let presenterUpdate = ProfileUpdatePresenter(profileUpdateService:ProfileUpdateService())
    var profileUpdate = [ProfileUpdateData]()

    var selectedSegmentValue = String()
    var imagePicker = UIImagePickerController()
    var uploadedImage = UIImage()
    let pickerView = UIPickerView()
    let monthArr = [String]()
    
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PhoneNoTextField: UITextField!
    @IBOutlet weak var EmailIdTextField: UITextField!
    @IBOutlet weak var SegmentControl: UISegmentedControl!
    @IBOutlet weak var saveProfileButton: UIButton!
    @IBOutlet weak var DOBTextField: TextFieldWithImage!
    
//    DOBTextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.callAPI()
        self.NameTextField.delegate = self
        self.PhoneNoTextField.delegate = self
        self.EmailIdTextField.delegate = self
        self.DOBTextField.delegate = self
        self.addBottomBorderTextField ()
        self.hideKeyboardWhenTappedAround()
        self.setUPSegmentControl()
        self.createPickerView()
    }

    override func viewDidLayoutSubviews(){
        
     saveProfileButton.addGradient(colors: [UIColor(red: 4.0 / 255.0, green: 105.0 / 255.0, blue: 215.0 / 255.0, alpha: 0.93), UIColor(red: 2.0 / 255.0, green: 53.0 / 255.0, blue: 108.0 / 255.0, alpha: 0.97)], locations: [0.1, 1.0])
    }
  
    func setUPSegmentControl () {
        
        SegmentControl.setTitle("Male", forSegmentAt: 0)
        SegmentControl.setTitle("Female", forSegmentAt: 1)
        SegmentControl.setTitle("Others", forSegmentAt: 2)
        SegmentControl.backgroundColor = UIColor(red: 234/255.0, green: 236/255.0, blue: 240/255.0, alpha: 1.0)
        SegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 13) as Any], for: .normal)
        SegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        SegmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 17/255.0, green: 89/255.0, blue: 168/255.0, alpha: 1.0)], for: .normal)
        SegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Lato-Bold", size: 13) as Any], for: .selected)
        
    }
    
    func addBottomBorderTextField () {
        
        self.NameTextField.addBottomBorder()
        self.PhoneNoTextField.addBottomBorder()
        self.EmailIdTextField.addBottomBorder()
        self.DOBTextField.addBottomBorder()
    }
    
    func callAPI () {
        
        presenter.attachView(view: self)
        presenter.getProfileDetails(user_id: "1")
        // Do any additional setup after loading the view.
    }
    
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    func createPickerView() {
//              pickerView.dataSource = self
//              pickerView.delegate = self
              pickerView.backgroundColor = UIColor.white
              pickerView.setValue(UIColor.black, forKeyPath: "textColor")
              DOBTextField.inputView = pickerView
              let toolBar = UIToolbar()
              toolBar.sizeToFit()
              let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
              let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
              let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

              toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
              toolBar.isUserInteractionEnabled = true
              toolBar.backgroundColor = UIColor.white
              toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
              DOBTextField.inputAccessoryView = toolBar

       }
       
       func dismissPickerView() {
        
          let toolBar = UIToolbar()
          toolBar.sizeToFit()
          let button = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.action))
          toolBar.setItems([button], animated: true)
          toolBar.isUserInteractionEnabled = true

       }
    
       @objc func cancel() {
             view.endEditing(true)
       }
       
       @objc func action() {
//             self.userNameArr.removeAll()
//             self.dobArr.removeAll()
//             self.mobileArr.removeAll()
//             self.wishStatusArr.removeAll()
//             let row = self.pickerView.selectedRow(inComponent: 0)
//             self.pickerView.selectRow(row, inComponent: 0, animated: false)
//             if self.month.isFirstResponder{
//                 month.text = self.monthArr[row]
//                 self.selectedMonthID = self.monIDArr[row]// selected item
//             }
             view.endEditing(true)
       }
    
    func setProfileDetails(full_name:String,phone_number:Int,email_id:String,dob:String,profile_pic:String) {
         self.ProfileImage.sd_setImage(with: URL(string: profile_pic), placeholderImage: UIImage(named: "placeholder.png"))
         self.NameTextField.text = full_name.capitalized
         self.EmailIdTextField.text = email_id.capitalized
//         self.PhoneNoTextField.text = phone_number
//         let seg = gender
//         let userRole = user_role
//         if userRole == "2"{
//            self.saveProfileOutlet.isHidden = true
//            self.name.isEnabled = false
//            self.phone.isEnabled = false
//            self.emailId.isEnabled = false
//            self.saveProfileOutlet.isEnabled = false
//            self.address.isEditable = false
//            self.genderSegment.isEnabled = false
//            self.userImageOutlet.isEnabled = false
//         }
//         else{
//            self.saveProfileOutlet.isHidden = false
//            self.name.isEnabled = true
//            self.phone.isEnabled = true
//            self.emailId.isEnabled = true
//            self.saveProfileOutlet.isEnabled = true
//            self.address.isEditable = true
//            self.genderSegment.isEnabled = true
//            self.userImageOutlet.isEnabled = true
//         }
//         if(seg == "M"){
//            SegmentControl.selectedSegmentIndex = 0
//            selectedSegmentValue = "M"
//         }
//         else if (seg == "F"){
//            SegmentControl.selectedSegmentIndex = 1
//            selectedSegmentValue = "F"
//         }
//         else {
//            SegmentControl.selectedSegmentIndex = 2
//            selectedSegmentValue = "O"
//        }
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    @IBAction func SegmentAction(_ sender: Any) {
        
    }
    
    @IBAction func changeImageAction(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
               alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                       self.openCamera()
               }))
                   
               alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                       self.openGallary()
               }))
                   
               alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
                   
               //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
               switch UIDevice.current.userInterfaceIdiom {
               case .pad:
                   alert.popoverPresentationController?.sourceView = sender as? UIView
                   alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
                   alert.popoverPresentationController?.permittedArrowDirections = .up
               default:
                   break
               }
                   
               self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera(){
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
        
    //MARK: - Choose image from camera roll
        
    func openGallary() {
         imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
         //If you dont want to edit the photo then you can set allowsEditing to false
         imagePicker.allowsEditing = true
         imagePicker.delegate = self
         self.present(imagePicker, animated: true, completion: nil)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         uploadedImage = (info[.originalImage] as? UIImage)!
         if  let editedImage = info[.originalImage] as? UIImage
         {
             self.ProfileImage.image = editedImage
             self.ProfileImage.clipsToBounds = true
         }
         //Dismiss the UIImagePicker after selection
//         self.picUploadAPI()
         picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveProfileAction(_ sender: Any) {
        self.updateAPI(name: self.NameTextField.text!, phone: self.PhoneNoTextField.text!,emailId: self.EmailIdTextField.text!,genderSegment: self.selectedSegmentValue, dob: self.DOBTextField.text!)
        
    }
    
    func updateAPI (name:String,phone:String,emailId:String,genderSegment:String,dob:String)
    {
        presenterUpdate.attachView(view: self)
        presenterUpdate.getProfileUpdate(user_id: "1", name: name, dob: dob, phone: phone, email: emailId, gender: genderSegment)
    }
}

extension Profile : ProfileUpdatesView, UITextFieldDelegate, UITextViewDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if NameTextField.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = NameTextField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if PhoneNoTextField.isFirstResponder
        {
            let maxLength = 10
            let currentString: NSString = PhoneNoTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else if EmailIdTextField.isFirstResponder
        {
            let maxLength = 30
            let currentString: NSString = EmailIdTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        else
        {
            let maxLength = 240
            let currentString: NSString = DOBTextField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.NameTextField){
            self.PhoneNoTextField.becomeFirstResponder()
        }
        else if (textField == self.PhoneNoTextField){
            self.EmailIdTextField.becomeFirstResponder()
        }
        else if (textField == self.EmailIdTextField){
            self.DOBTextField.becomeFirstResponder()
        }

        return true
       }
    
    func startLoadingUpdate() {
           //
       }
       
    func finishLoadingUpdate() {
           //
       }
       
    func setProfileUpdate(msg: String, status: String) {
           if  status == "success"{
               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
                   self.navigationController?.popViewController(animated: true)
               })
           }
       }
       
    func setEmptyUpdate(errorMessage: String) {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            })
       }
    
       /*
       // MARK: - Navigation

       // In a storyboard-based application, you will often want to do a little preparation before navigation
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           // Get the new view controller using segue.destination.
           // Pass the selected object to the new view controller.
       }
       */
    
}
