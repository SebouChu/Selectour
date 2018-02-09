//
//  SearchViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var peopleSlider: UISlider!
    @IBOutlet weak var peopleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        peopleLabel.text = Int(peopleSlider.value).description
        searchBtn.layer.cornerRadius = 17.0
        
        for textField in textFields {
            textField.delegate = self
            textField.layer.cornerRadius = 5.0
            textField.layer.borderColor = UIColor(red: 1, green: 106/255, blue: 0, alpha: 1).cgColor
            textField.layer.borderWidth = 1.5
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        peopleLabel.text = Int(sender.value).description
    }
    
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.currentIndex = 2
        self.present(menuVC!, animated: true, completion: nil)
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        print("search")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        for textField in textFields {
            textField.resignFirstResponder()
        }
    }
}
