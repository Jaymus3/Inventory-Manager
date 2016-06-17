//
//  PartModel.swift
//  Inventory Manager
//
//  Created by Sturtevant Auto on 6/14/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import Foundation
import UIKit


protocol PartProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class PartModel: NSObject, NSURLSessionDataDelegate
{
    
    weak var delegate: PartProtocol!
    var data : NSMutableData = NSMutableData()
    let urlPath: String = "http://192.168.1.38/ipodinterface/get.php?stock=" + mainInstance.stock

func downloadItems() {
    
    let url: NSURL = NSURL(string: urlPath)!
    var session: NSURLSession!
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    
    
    session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    
    let task = session.dataTaskWithURL(url)
    
    task.resume()
    
}

func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
    self.data.appendData(data);
    
}

func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
    if error != nil {
        print("Failed to download data")
        print(error)
    }else {
        print("Data downloaded")
        self.parseJSON()
    }
    
}
func parseJSON() {
    
    var jsonResult: NSMutableArray = NSMutableArray()
    
    do{
        jsonResult = try NSJSONSerialization.JSONObjectWithData(self.data, options:NSJSONReadingOptions.AllowFragments) as! NSMutableArray
        
    } catch let error as NSError {
        print(error)
        
    }
    
    var jsonElement: NSDictionary = NSDictionary()
    let locations: NSMutableArray = NSMutableArray()
    
    for i in 0 ..< jsonResult.count
    {
        jsonElement = jsonResult[i] as! NSDictionary
        
        let part = Part()
        //the following insures none of the JsonElement values are nil through optional binding
        if let name = jsonElement["Name"] as? String,
           let conditions = jsonElement["Conditions"] as? String,
           let make = jsonElement["Make"] as? String,
           let model = jsonElement["Model"] as? String,
           let year = jsonElement["Year"] as? String,
           let stock = jsonElement["Stock"] as? String
        {
        print(stock)
        print(mainInstance.stock)
            mainInstance.partc += 1
            print(name)
            print(make)
            print(model)
            print(stock)
            part.name = name
            let condint = Int(conditions)
            part.conditions = condint
            let noPhoto = UIImage(named: "noPhoto")!
            part.photo = noPhoto
            part.make = make
            part.model = model
            let yearint = Int(year)
            part.year = yearint
            part.stock = stock
            mainInstance.stock = stock
            mainInstance.make = make
            mainInstance.model = model
            mainInstance.year = year
            
        }
        
        locations.addObject(part)
        
    }
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        self.delegate.itemsDownloaded(locations)
        
    })
}
}