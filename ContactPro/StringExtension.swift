//
//  StringExtension.swift
//  ContactPro
//
//  Created by Appkoder on 30/09/2016.
//  Copyright © 2016 Appkoder. All rights reserved.
//

import Foundation

extension String
{
    func removeSpaces() -> String
    {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
