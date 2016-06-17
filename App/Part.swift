//
//  Part.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 5/31/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import UIKit
import Foundation

class Part: NSObject {
    //MARK: Variables
    var name: String?
    var photo: UIImage?
    var conditions: Int?
    var make: String?
    var model: String?
    var year: Int?
    var stock: String?
    
    //MARK: Types
    
    override init()
    {
        
    }
    
    init(name: String, photo: UIImage, conditions: Int, make: String, model: String, year: Int, stock: String)
    {
        self.name = name
        self.photo = photo
        self.conditions = conditions
        self.make = make
        self.model = model
        self.year = year
        self.stock = stock
    }
    
    override var description: String {
        return "Name: \(name), Photo: \(photo), Conditions: \(conditions), Make: \(make), Model: \(model), Year: \(year), Stock: \(stock)"
        
    }

    
}
