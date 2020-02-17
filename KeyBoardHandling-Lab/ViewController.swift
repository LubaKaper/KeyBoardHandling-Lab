//
//  ViewController.swift
//  KeyBoardHandling-Lab
//
//  Created by Liubov Kaper  on 2/16/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var userNameTF: UITextField!
    
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var imageCenterYConstraint: NSLayoutConstraint!
    
    private var originalYConstraint: NSLayoutConstraint!
    
    private var keyboardIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        
        userNameTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }

    // call this function to let view controller start listening for keyboard
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
   @objc private func keyboardWillShow(_ notification: NSNotification) {
       // print("keyboardWillShow")
   // print(notification.userInfo)
   // UIKeyboardFrameBeginUserInfoKey
    
    guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
        return
    }
   
    movekeyboardUp(keyboardFrame.size.height)
    //print("keyboard frome is \(keyboardFrame)")
    // if you do just this, keyboard will continue going up
   
    }
   //  NSNotifications communicate changes
  @objc  private func keyboardWillHide(_ notification: NSNotification) {
//    print("keyboardWillHide")
//        print(notification.userInfo)
    resetUI()
    
    }
    
    private func movekeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalYConstraint = imageCenterYConstraint // saved original constraint
        imageCenterYConstraint.constant -= (height * 0.80)
         keyboardIsVisible = true
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        imageCenterYConstraint.constant -= originalYConstraint.constant
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetUI()
        return true
    }
}

