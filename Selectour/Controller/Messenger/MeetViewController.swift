//
//  MeetViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class MeetViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var successView: UIView!
    @IBOutlet weak var successLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToChatFromMeet", sender: self)
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "fr_FR")
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let date = datePicker.date
        let time = timePicker.date
        
        let dateString = dateFormatter.string(from: date)
        let timeString = timeFormatter.string(from: time)
        
//        print("Date : \(dateString)")
//        print("Time : \(timeString)")
        
        successLabel.text = "Bravo ! Vous avez pris rendez-vous avec Julien, le \(dateString) à \(timeString) !"
        
        successView.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.successView.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            // Fade in
            UIView.animate(withDuration: 1.0, delay: 5.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.successView.alpha = 0.0
            }, completion: { (finished: Bool) in
                self.successView.isHidden = true
            })
        })
    }
    
}
