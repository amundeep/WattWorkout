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

    
    //Outlets
    @IBOutlet var workoutTable: UITableView!
    @IBOutlet weak var settings: UIBarButtonItem!
    
    
    //Variables and Constants
//    var workouts: [Workout] = globalVar.tableData
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var wos = [NSManagedObject]()


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Edit/Done button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
//        
//        var emptyWorkoutArray: [Workout] = []
//        if ( !(def.objectForKey(userDataKey) as! [Workout]).isEmpty ) {
//            println("Not Empty")
//            globalVar.tableData = (def.objectForKey(userDataKey) as? [Workout])!
//        }
//        
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
 
//            workouts.insert(addWorkoutViewController.newWorkout, atIndex: 0)
            self.saveWorkoutCD(addWorkoutViewController.newWorkout)
            
            let indexPath = NSIndexPath(forRow: wos.count-1, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
        }

        tableView.reloadData()
    }
    
//    
//    @IBAction func editWorkouts(sender: UIBarButtonItem) {
//        self.editing = !self.editing
//    }
    
    
    
    func saveWorkoutCD(wo: Workout) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("Workout", inManagedObjectContext: managedContext)
        
        let workoutCD = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //Settings Core Data values
        workoutCD.setValue(wo.name, forKey: "name")
        workoutCD.setValue(wo.value, forKey: "value")
        workoutCD.setValue(wo.datemod, forKey: "timeStamp")
        workoutCD.setValue(wo.type, forKey: "type")
        
        //Error handling
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        wos.insert(workoutCD, atIndex: 0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let sort = NSSortDescriptor(key: "order", ascending: true)
        
        let fetchRequest = NSFetchRequest(entityName: "Workout")
        fetchRequest.sortDescriptors = [sort]
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults {
            wos = results
        } else {
            println("Could not retrieve data")
        }
        
    }
    
    
    
    
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println(wos.count)
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                println(indexPath.row)
                let object: AnyObject? = wos[indexPath.row].valueForKey("name")
                (segue.destinationViewController as! DetailViewController).detailItem = object as! String
                let object2: AnyObject? = wos[indexPath.row].valueForKey("timeStamp")
                (segue.destinationViewController as! DetailViewController).detailDate = object2 as! NSDate
                
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
        return wos.count
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //MOVE CELL
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        var old = fromIndexPath.row
        var new = toIndexPath.row
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("Workout", inManagedObjectContext: managedContext)
        
        let blah = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        blah.setValue(new, forKey: "order")
        
//        let workoutCD = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
//        
//        var request = NSFetchRequest(entityName: "Workout")
//        var results: NSArray = managedContext.executeFetchRequest(request, error: nil)!
//        println("RESULTS: " + results.description)
//        
        var itemToMove = wos[old]
//        managedContext.deleteObject(wos[old])
        wos.removeAtIndex(old)
//        managedContext.insertObject(itemToMove)
        wos.insert(itemToMove, atIndex: new)
        
        
        if(new > old) {
            for var i = old + 1; i <= new; ++i {
                var temp = i - 1
                wos[i].setValue(temp, forKey: "order")
            }
            wos[new].setValue(new, forKey: "order")
        } else {
            for var i = old - 1; i >= new; --i {
                var temp = i + 1
                wos[i].setValue(temp, forKey: "order")
            }
            wos[new].setValue(new, forKey: "order")
        }
        
        
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    //DELETE CELL
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext!

            var workoutCD = wos[indexPath.row]
            
            managedContext.deleteObject(workoutCD)
            wos.removeAtIndex(indexPath.row)
            workoutTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not save \(error), \(error?.userInfo)")
            }
        }
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
    
    func sortFunc(obj1: NSManagedObject, obj2: NSManagedObject) -> Bool {
        
        return ( (obj1.valueForKey("order") as? Int) < (obj2.valueForKey("order") as? Int) )
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkoutCell", forIndexPath: indexPath) as! UITableViewCell
//        self.configureCell(cell, atIndexPath: indexPath)
        
//        let workout = workouts[indexPath.row] as Workout
        
        var wosSorted = sorted(wos, sortFunc)
        
        println(wosSorted)
        
        let wo = wosSorted[indexPath.row]
        
        if let workoutLabel = cell.viewWithTag(101) as? UILabel {
            workoutLabel.text = wo.valueForKey("name") as? String
        }
        if let workoutValue = cell.viewWithTag(102) as? UILabel {
            workoutValue.text = wo.valueForKey("value") as? String
            println(wo.valueForKey("value")?.description)
        }
        if let latestDate = cell.viewWithTag(103) as? UILabel {
            //WILL HAVE TO CHANGE BASED ON USER DEFAULTS
//            var cellWidth = cell.contentView.frame.size.width
//            var x = dateLabel.frame.origin.x
//            var y = dateLabel.frame.origin.y
//            var h = dateLabel.frame.height
//            dateLabel.frame = CGRectMake(x, y, cellWidth/4, h)
            
            
            let date = wo.valueForKey("timeStamp") as? NSDate
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            latestDate.text = formatter.stringFromDate(date!)
        }
        if let workoutImage = cell.viewWithTag(100) as? UIImageView {
            workoutImage.image = self.getWorkoutImage(wo.valueForKey("type") as! String)
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

