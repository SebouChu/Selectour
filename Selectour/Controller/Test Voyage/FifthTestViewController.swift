//
//  FifthTestViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class FifthTestViewController: UIViewController {

    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var meetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatBtn.layer.cornerRadius = 17.0
        meetBtn.layer.cornerRadius = 17.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func ignoreBtnPressed(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: "testDone")
        let discoverVC = self.storyboard?.instantiateViewController(withIdentifier: "DiscoverViewController") as? DiscoverViewController
        self.present(discoverVC!, animated: true, completion: nil)
    }
    
}
