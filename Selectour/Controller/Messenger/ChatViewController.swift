//
//  ChatViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var message1: UIView!
    @IBOutlet weak var message2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.messageTextField.frame.height))
        messageTextField.leftView = paddingView
        messageTextField.leftViewMode = .always
        
        messageTextField.delegate = self
        messageTextField.layer.borderColor = UIColor.lightGray.cgColor
        messageTextField.layer.borderWidth = 1.0
        messageTextField.layer.cornerRadius = 17.5
        
        arrowBtn.layer.cornerRadius = 17.5
        
        message1.layer.cornerRadius = 17.5
        message2.layer.cornerRadius = 17.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.currentIndex = 3
        self.present(menuVC!, animated: true, completion: nil)
    }
    
    //TODO: Declare textFieldDidBeginEditing here:
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 318
            self.view.layoutIfNeeded()
        }
    }
    
    
    //TODO: Declare textFieldDidEndEditing here:
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 60
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        messageTextField.resignFirstResponder()
    }

}
