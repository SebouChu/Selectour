//
//  MenuViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    var currentIndex: Int = 0

    @IBOutlet var menuItems: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentItem = menuItems[currentIndex]
        for item in menuItems {
            item.setTitleColor(UIColor.lightGray, for: .normal)
        }
        currentItem.setTitleColor(UIColor(red: 255/255, green: 106/255, blue: 0, alpha: 1), for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func itemBtnPressed(_ sender: UIButton) {
        print(sender.tag)
        if sender.tag == currentIndex {
            self.dismiss(animated: true, completion: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        } else {
            var nextSegueID = ""
            switch (sender.tag) {
            case 0:
                nextSegueID = "goToDiscover"
                break
            case 1:
                nextSegueID = "goToDeals"
                break
            case 2:
                nextSegueID = "goToSearch"
                break
            case 3:
                nextSegueID = "goToChat"
                break
            case 4:
                nextSegueID = "goToTest"
                break
            default:
                nextSegueID = "goToDiscover"
                break
            }
            print(nextSegueID)
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            self.performSegue(withIdentifier: nextSegueID, sender: self)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
