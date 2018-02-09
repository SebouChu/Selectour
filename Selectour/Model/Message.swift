//
//  Message.swift
//  Selectour
//
//  Created by Sébastien Gaya on 09/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import Foundation

class Message: NSObject, NSCoding {
    enum Sender: String {
        case advisor = "Advisor"
        case customer = "Customer"
    }
    
    var sender: Sender
    var message: String
    
    init(sender: Sender, message: String) {
        self.sender = sender
        self.message = message
    }
    
    required init(coder decoder: NSCoder) {
        self.sender = Sender(rawValue: decoder.decodeObject(forKey: "sender") as? String ?? "Customer")!
        self.message = decoder.decodeObject(forKey: "message") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.message, forKey: "message")
        coder.encode(self.sender.rawValue, forKey: "sender")
    }
}
