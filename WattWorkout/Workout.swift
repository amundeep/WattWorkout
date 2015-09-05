//
//  Workout.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/4/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import UIKit

class Workout: NSObject {
    
    var type: String
    var name: String
    var value: Double
    
    
    init(wType: String, wName: String, cValue: Double){
        type = wType
        name = wName
        value = cValue
        super.init()
    }
   
}
