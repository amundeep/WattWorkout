//
//  AddWorkoutTableViewController.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/3/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import UIKit
import Foundation


class AddWorkoutTableViewController: UITableViewController {
    
    var workouts: [Workout] = globalVar.tableData
    
    var wName: String!
    var wType: String = "Lift"
    var defValue = 0.0
    var newWorkout: Workout!
    
    @IBOutlet weak var workoutName: UITextField!
    @IBOutlet weak var workoutType: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cells = tableView.visibleCells() as? [UITableViewCell] {
            for c in cells {
                if c.accessoryType == UITableViewCellAccessoryType.Checkmark {
                    c.accessoryType = UITableViewCellAccessoryType.None
                }
            }
        }
        
        if indexPath.section == 0 {
            workoutName.becomeFirstResponder()
        } else if indexPath.section == 1 {
            var index = indexPath.row
            switch index {
            case 2:
                wType = "Strength"
            case 1:
                wType = "Cardio"
            case 0:
                fallthrough
            default:
                wType = "Lift"
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "SaveWorkoutDetail"){
            if !(workoutName.text.isEmpty) {
                wName = workoutName.text
                return true
            }else{
                var alert = UIAlertController(title: "Need name!", message: "Your workout needs a name, please enter one.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveWorkoutDetail" {
            defValue = 0.0
            println("Name: " + wName + "\nType: " + wType + "\nValue: " + defValue.description)
            newWorkout = Workout(wType: wType, wName: wName, cValue: defValue)
            workouts.insert(newWorkout, atIndex: 0)
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
