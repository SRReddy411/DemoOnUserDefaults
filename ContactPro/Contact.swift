//
//  Contact.swift
//  ContactPro
//
//  Created by Appkoder on 30/09/2016.
//  Copyright © 2016 Appkoder. All rights reserved.
//

import UIKit

class Contact: NSObject, NSCoding {

    let name: String
    let phone: String
    let imageName: String
    
    init(name: String, phone: String, imageName: String)
    {
        self.name = name
        self.phone = phone
        self.imageName = imageName
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        name = aDecoder.decodeObject(forKey: "name") as! String
        phone = aDecoder.decodeObject(forKey: "phone") as! String
        imageName = aDecoder.decodeObject(forKey: "imageName") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(imageName, forKey: "imageName")
    }
}
