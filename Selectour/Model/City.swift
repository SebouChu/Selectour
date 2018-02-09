//
//  City.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import Foundation
import UIKit

class City {
    var name: String
    var price: String
    var image: UIImage
    
    init(name: String, price: Int, imageName: String) {
        self.name = name
        self.price = "\(price)€"
        self.image = UIImage(named: imageName)!
    }
}
