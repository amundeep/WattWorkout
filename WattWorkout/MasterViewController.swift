//
//  MasterViewController.swift
//  WattWorkout
//
//  Created by Amundeep Singh on 9/3/15.
//  Copyright (c) 2015 Amundeep Singh. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet var workoutTable: UITableView!
    
    @IBOutlet weak var settings: UIBarButtonItem!
//    var tbItems = [UIBarButtonItem]()
    
//    var themeColor = UIColor(red: 255, green: 153, blue: 51, alpha: 1)
    var workouts: [Workout] = tableData
    
    var managedObjectContext: NSManagedObjectContext? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Edit/Done button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
//        //Settings button
//        let button: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        button.setImage(UIImage(named: "settings.png"), forState: UIControlState.Normal)
//        button.addTarget(self, action: "settingsPressed", forControlEvents: UIControlEvents.TouchUpInside)
//        button.frame = CGRectMake(0,0,30,30)
//        
//        let settingsButton = UIBarButtonItem(customView: button)
//        self.navigationItem.leftBarButtonItem = settingsButton
//
//        tbItems.append(self.editButtonItem())
// Do any additional setup after loading the view, typically from a nib.
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
//        self.workoutTable.reloadData()
        
    }
    
    @IBAction func cancelToDashboard(segue: UIStoryboardSegue) {
        
        
    }
    
    @IBAction func saveWorkoutDetail(segue: UIStoryboardSegue) {
        
        if let addWorkoutViewController = segue.sourceViewController as? AddWorkoutTableViewController {
 
            workouts.insert(addWorkoutViewController.workout, atIndex: 0)
            
            let indexPath = NSIndexPath(forRow: workouts.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            
        }

        tableView.reloadData()
    }
    
//    
//    @IBAction func editWorkouts(sender: UIBarButtonItem) {
//        self.editing = !self.editing
//    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        var itemToMove = workouts[fromIndexPath.row]
        workouts.removeAtIndex(fromIndexPath.row)
        workouts.insert(itemToMove, atIndex: toIndexPath.row)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            workouts.removeAtIndex(indexPath.row)
            workoutTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        let context = self.fetchedResultsController.managedObjectContext
//        let entity = self.fetchedResultsController.fetchRequest.entity!
//        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! NSManagedObject
//             
//        // If appropriate, configure the new managed object.
//        // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
//        newManagedObject.setValue(NSDate(), forKey: "timeStamp")
//             
//        // Save the context.
//        var error: NSError? = nil
//        if !context.save(&error) {
//            // Replace this implementation with code to handle the error appropriately.
//            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            //println("Unresolved error \(error), \(error.userInfo)")
//            abort()
//        }
//    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(workouts.count)
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                println(indexPath.row)
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
                (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.fetchedResultsController.sections?.count ?? 0
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
//        return sectionInfo.numberOfObjects
        return workouts.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

    func getWorkoutImage(type: String) -> UIImage?{
        switch type{
        case "Lift":
            return UIImage(named: "WattLiftIcon")
        case "Cardio":
            return UIImage(named: "WattRunIcon")
        case "Strength":
            return UIImage(named: "WattStrIcon")
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutCell", forIndexPath: indexPath) as! UITableViewCell
//        self.configureCell(cell, atIndexPath: indexPath)
        
        let workout = workouts[indexPath.row] as Workout
        
        if let workoutLabel = cell.viewWithTag(101) as? UILabel {
            workoutLabel.text = workout.name
        }
        if let workoutValue = cell.viewWithTag(102) as? UILabel {
            workoutValue.text = workout.value.description
            println(workout.value.description)
        }
        if let latestDate = cell.viewWithTag(103) as? UILabel {
            //WILL HAVE TO CHANGE BASED ON USER DEFAULTS
//            var cellWidth = cell.contentView.frame.size.width
//            var x = dateLabel.frame.origin.x
//            var y = dateLabel.frame.origin.y
//            var h = dateLabel.frame.height
//            dateLabel.frame = CGRectMake(x, y, cellWidth/4, h)
            
            let date = NSDate()
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            latestDate.text = formatter.stringFromDate(date)
        }
        if let workoutImage = cell.viewWithTag(100) as? UIImageView {
            workoutImage.image = self.getWorkoutImage(workout.type)
        }
        
//        cell.textLabel?.text = workout.name
//        cell.detailTextLabel?.text = workout.value.description
        return cell
    }

 

    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
            let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        cell.textLabel!.text = object.valueForKey("timeStamp")!.description
    }

    // MARK: - Fetched results controller

    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        let sortDescriptors = [sortDescriptor]
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
    	var error: NSError? = nil
    	if !_fetchedResultsController!.performFetch(&error) {
    	     // Replace this implementation with code to handle the error appropriately.
    	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             //println("Unresolved error \(error), \(error.userInfo)")
    	     abort()
    	}
        
        return _fetchedResultsController!
    }    
    var _fetchedResultsController: NSFetchedResultsController? = nil

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
            case .Insert:
                self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Update:
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         self.tableView.reloadData()
     }
     */

}

