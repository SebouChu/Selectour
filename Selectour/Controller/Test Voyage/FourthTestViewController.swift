//
//  FourthTestViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class FourthTestViewController: UIViewController {

    @IBOutlet weak var discoverBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        discoverBtn.layer.cornerRadius = 17.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
