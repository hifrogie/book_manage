//
//  KeyboardClass.swift
//  BookManangement
//
//  Created by uniwiz on 11/13/23.
//

import Foundation
import UIKit

extension ViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 1) {
                    Utility.getRootViewController()?.view.window?.frame.origin.y -= keyboardHeight
                }
            }
        }
    
    @objc func keyboardWillHide(notification: NSNotification) {
           if Utility.getRootViewController()?.view.window?.frame.origin.y != 0 {
               if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                       let keyboardRectangle = keyboardFrame.cgRectValue
                       let keyboardHeight = keyboardRectangle.height
                   UIView.animate(withDuration: 1) {
                       Utility.getRootViewController()?.view.window?.frame.origin.y += keyboardHeight
                   }
               }
           }
       }
    func setKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
        
    }
    
}
