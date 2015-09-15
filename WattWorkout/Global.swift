//
//  TableData.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/4/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import CoreData

var userDataKey = "keyWorkouts"
var def = NSUserDefaults.standardUserDefaults()

class Global {
    
    var tableData = [Workout]()

    init(data:[Workout]){
//        
//        if def.objectForKey(userDataKey) != nil {
//            var testArray: AnyObject? = def.objectForKey(userDataKey)
////            var readArray : String = testArray! as! String
////            println("USER DATA: " + readArray)
//        } else {
//            println("USER DATA: EMPTY")
//        }
        
        self.tableData = data
    }
    
}


var globalVar = Global(data: [])
