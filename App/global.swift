//
//  global.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 6/14/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import Foundation

class Main {
    var stock:String
    var model:String
    var make:String
    var year:String
    var partc:Int
    init(stock:String, model:String, make:String, year:String, partc:Int) {
        self.stock = stock
        self.model = model
        self.make = make
        self.year = year
        self.partc = partc
    }
}
var mainInstance = Main(stock:"G0DEFAULT",model: "DEFAULT",make: "DEFAULT",year: "DEFAULT", partc: 0)