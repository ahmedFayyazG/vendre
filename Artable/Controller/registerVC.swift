//
//  registerVC.swift
//  Artable
//
//  Created by AHMED on 03/11/2019.
//  Copyright © 2019 AHMED. All rights reserved.
//

import UIKit
import Firebase

class registerVC: UIViewController ,UITextFieldDelegate{
    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var passwordCheck: UIImageView!
    @IBOutlet weak var confPassCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTxt.delegate = self
        confirmPassTxt.delegate = self
        
        passwordTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            confirmPassTxt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField)
    {
        guard let passTxt = passwordTxt.text else
        {return}
        
        
        //Password matching For Green
        if passwordTxt == confirmPassTxt {
            passwordCheck.isHidden = false
            confPassCheck.isHidden = false
        }else
        {
            if passTxt.isEmpty{
                passwordCheck.isHidden = true
                confPassCheck.isHidden = true
                confirmPassTxt.text = ""
            }
        }
        
        //For Password Matching
        if passwordTxt.text == confirmPassTxt.text {
            passwordCheck.image = UIImage(named: AppImages.GreenCheck)
            confPassCheck.image = UIImage(named:AppImages.GreenCheck)
        }else
        {
            passwordCheck.image = UIImage(named: AppImages.RedCheck)
            confPassCheck.image = UIImage(named:AppImages.RedCheck)
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        guard let email = emailTxt.text , !email.isNotEmpty,
        let username = userNameTxt.text , !username.isNotEmpty,
        let password = passwordTxt.text , !password.isNotEmpty
        else
        {return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error{
                debugPrint(error)
                return  }
            print("Succesfully Register NewUser!")
        }
    }
    
}
