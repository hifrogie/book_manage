//
//  KeyboardClass.swift
//  BookManangement
//
//  Created by uniwiz on 11/13/23.
//

import Foundation
import UIKit

extension ViewController: UIGestureRecognizerDelegate {
    
    func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.delegate = self
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let editingTextField = findEditingTextField(), editingTextField.isFirstResponder {
               NotificationCenter.default.post(name: UIResponder.keyboardWillHideNotification, object: nil)
               editingTextField.resignFirstResponder()
           } else {
               // 현재 화면에서 편집 중이 아니면 키보드 숨김
               self.view.endEditing(true)
           }
    }
    
    private func findEditingTextField() -> UITextField? {
        for subview in view.subviews {
            if let textField = subview as? UITextField, textField.isFirstResponder {
                return textField
            }
        }
        return nil
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           Utility.getRootViewController()?.view.window?.frame.origin.y == 0.0 {
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
