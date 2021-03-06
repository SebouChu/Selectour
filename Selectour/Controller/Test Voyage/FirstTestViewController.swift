//
//  FirstTestViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class FirstTestViewController: UIViewController {

    @IBOutlet var choicesBtns: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(0, forKey: "firstChoice")
        
        for choiceBtn in choicesBtns {
            choiceBtn.imageView?.contentMode = .scaleAspectFit
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func choiceBtnPressed(_ sender: UIButton) {
        //print(sender.tag)
        UserDefaults.standard.setValue(sender.tag, forKey: "firstChoice")
        self.performSegue(withIdentifier: "goToSecondChoice", sender: self)
    }
    
    @IBAction func ignoreBtnPressed(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "testDone")
        let discoverVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController") as? DiscoverViewController
        self.present(discoverVC!, animated: true, completion: nil)
    }
}

