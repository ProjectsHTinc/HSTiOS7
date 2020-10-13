//
//  otp.swift
//  SPV
//
//  Created by HappySanz Tech on 10/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class otp: UIViewController,UITextFieldDelegate,LoginView {

    var otp = String()
    var mobileNumber = String()
    var otpData = [OtpData]()
    let presenterLoginService = LoginPresenter(loginService: LoginService())
    let presenterOtpService = OTPPresenter(oTPService: OTPService())
    
    @IBOutlet var backView: UIView!
    @IBOutlet var textfield1: UITextField!
    @IBOutlet var textfield2: UITextField!
    @IBOutlet var textfield3: UITextField!
    @IBOutlet var textfield4: UITextField!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        activityView.isHidden = true
        self.hideKeyboardWhenTappedAround()
        view.bindToKeyboard()
        self.setTextfieldDelegates()
        self.textfield1.addBottomBorder()
        self.textfield2.addBottomBorder()
        self.textfield3.addBottomBorder()
        self.textfield4.addBottomBorder()
        
    }
    override func viewDidLayoutSubviews(){
              verifyButton.addGradient(colors: [UIColor(red: 4.0 / 255.0, green: 105.0 / 255.0, blue: 215.0 / 255.0, alpha: 1.0), UIColor(red: 2.0 / 255.0, green: 53.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)], locations: [0.1, 1.0])
          }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // On inputing value to textfield
        if ((textField.text?.count)! < 1  && string.count > 0){
            if(textField == textfield1)
            {
                textfield2.becomeFirstResponder()
            }
            if(textField == textfield2)
            {
                textfield3.becomeFirstResponder()
            }
            if(textField == textfield3)
            {
                textfield4.becomeFirstResponder()
            }

            textField.text = string
            return false
        }
        else if ((textField.text?.count)! >= 1  && string.count == 0){
            // on deleting value from Textfield
            textfield1.text = ""
            textfield2.text = ""
            textfield3.text = ""
            textfield4.text = ""
            textfield1.becomeFirstResponder()
            return false
        }
        else if ((textField.text?.count)! >= 1  )
        {
            textField.text = string
            return false
        }
        return true
    }
    
    func setTextfieldDelegates ()
    {
        /*Set Delegates*/
        self.textfield1.delegate = self
        self.textfield2.delegate = self
        self.textfield3.delegate = self
        self.textfield4.delegate = self
    }
    
    func startLoading()
       {
           /*Hide Activity View*/
           activityView.isHidden = false
           activityView.startAnimating()
       }
       
    func finishLoading()
       {
           activityView.isHidden = true
           activityView.stopAnimating()
       }
       
    func setLoginOtp(login_otp: String) {
             self.otp = login_otp
        }
        
    func setEmptyLogin(errorMessage: String) {
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
             })
        }
    
    @IBAction func resendOTP(_ sender: Any) {
        
        presenterLoginService.attachView(view: self)
        presenterLoginService.getOtp(mobile_no: self.mobileNumber)
        
    }
    
    @IBAction func verifyButton(_ sender: Any) {
        
        guard CheckValuesAreEmpty () else {
                  return
              }
              
              self.otpSuccess ()
        
    }
    
    func CheckValuesAreEmpty () -> Bool{
           
           let attchedText = "\(textfield1.text ?? "")\(textfield2.text ?? "")\(textfield3.text ?? "")\(textfield4.text ?? "")"

           
           guard Reachability.isConnectedToNetwork() == true else{
                 AlertController.shared.offlineAlert(targetVc: self, complition: {
                   //Custom action code
                })
                return false
           }
           
           guard self.textfield1.text?.count != 0 && self.textfield2.text?.count != 0 && self.textfield3.text?.count != 0 && self.textfield4.text?.count != 0 else {
               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "empty", complition: {
                   
                })
                return false
            }
           
           guard attchedText == self.otp else {
               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.OTPAlertMessage, complition: {
                   
                })
                return false
            }
           
             return true
       }
    
    func otpSuccess ()
    {
        presenterOtpService.attachView(view: self)
        presenterOtpService.getOtpForOtpPage(mobile_no: self.mobileNumber, otp: self.otp)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // Get the new view controller using segue.destination.
       // Pass the selected object to the new view controller.
       if (segue.identifier == ""){
//        _ = segue.destination as!
       }
       }
    
}

extension otp: OtpView {
    
    func startLoadingOtp() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    func finishLoadingOtp() {
         activityView.isHidden = true
         activityView.stopAnimating()
    }
    func setOtp(otpValue: [OtpData]) {
         otpData = otpValue
         self.performSegue(withIdentifier: "", sender: self)
    }
    func setEmptyOtp(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
}


