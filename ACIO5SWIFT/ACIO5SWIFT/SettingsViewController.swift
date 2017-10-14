
//  SettingsViewController.swift
//  ACIO5SWIFT
//
//  Created by Charles Zillmann on 10/5/17.
//  Copyright © 2017 Charles Zillmann. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Eureka

//**********************************************************************************************
//**********************************************************************************************
//***** Settings
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class SettingsViewController
//*****************************************************
class SettingsViewController : UIViewController {
    @IBOutlet weak var done: UIBarButtonItem!
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //***********
    //***** @IBAction func done
    //***********
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

//**********************************************************************************************
//**********************************************************************************************
//***** Users
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class UsersTableViewController
//*****************************************************
class UsersTableViewController : UITableViewController, NSFetchedResultsControllerDelegate {
    var myUsers = [Users]()
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Users"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoDone))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(DoAdd))
    }
    
    //***********
    //***** override func tableView numberOfRowsInSection
    //***********
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myUsers.count
    }
    
    //***********
    //***** override func tableView cellForRowAt
    //***********
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCell(withIdentifier: "UsersCellIdentifier", for: indexPath as IndexPath) as! UserCell
        myCell.myTableVC = self
        
        //Access the Deployments Array and set the label values for display
        let myUForCell = myUsers[indexPath.row]
        myCell.namelabel?.text = myUForCell.name
        return myCell
    }
    
    //***********
    //***** @objc func DoDone
    //***********
    @objc func DoDone(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //***********
    //***** @objc func DoAdd
    //***********
    @objc func DoAdd(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let myUForCell = Users(context: context) // Link Task & Context
        myUForCell.name = "New User"
        self.myUsers.insert(myUForCell, at: 0)
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}

//*****************************************************
//***** class UserCell
//*****************************************************
class UserCell : UITableViewCell{
    
    @IBOutlet weak var namelabel: UILabel!
    var myTableVC: UsersTableViewController?
    
    //***********
    //***** override init
    //***********
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetUpViews()
    }
    //***********
    //***** required init?
    //***********
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //***********
    //***** func SetUpViews
    //***********
    func SetUpViews(){
    }
}

//**********************************************************************************************
//**********************************************************************************************
//***** NamingConventions
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class NamingConventionsTableViewController
//*****************************************************
class NamingConventionsTableViewController : UITableViewController, NSFetchedResultsControllerDelegate {
    var myNamingConventions = [NamingConvention]()
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Naming Conventions"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoDone))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(DoAdd))
    }
    
    //***********
    //***** override func tableView numberOfRowsInSection
    //***********
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNamingConventions.count
    }
    
    //***********
    //***** override func tableView cellForRowAt
    //***********
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCell(withIdentifier: "NamingConventionCellIdentifier", for: indexPath as IndexPath) as! NamingConventionCell
        myCell.myTableVC = self
        
        //Access the Deployments Array and set the label values for display
        let myNCForCell = myNamingConventions[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        myCell.nccreatedlabel?.text = "Created: " + formatter.string(from: myNCForCell.created!)
        myCell.ncmodifiedlabel?.text = "Modified: " + formatter.string(from: myNCForCell.modified!)
        myCell.ncnamelabel?.text = myNCForCell.name
        return myCell
    }
    
    //***********
    //***** @objc func DoDone
    //***********
    @objc func DoDone(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //***********
    //***** @objc func DoAdd
    //***********
    @objc func DoAdd(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let myNCForCell = NamingConvention(context: context) // Link Task & Context
        myNCForCell.name = "New Naming Convention"
        myNCForCell.created = NSDate() as Date
        myNCForCell.modified = myNCForCell.created
        self.myNamingConventions.insert(myNCForCell, at: 0)
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //self.dismiss(animated: false, completion: nil)
    }
}

//*****************************************************
//***** class NamingConventionCell
//*****************************************************
class NamingConventionCell : UITableViewCell{
    
    @IBOutlet weak var ncmodifiedlabel: UILabel!
    @IBOutlet weak var nccreatedlabel: UILabel!
    @IBOutlet weak var ncnamelabel: UILabel!
    var myTableVC: NamingConventionsTableViewController?
    
    //***********
    //***** override init
    //***********
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetUpViews()
    }
    //***********
    //***** required init?
    //***********
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //***********
    //***** func SetUpViews
    //***********
    func SetUpViews(){
    }
}

//**********************************************************************************************
//**********************************************************************************************
//***** MasterBuildTask
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class MasterBuildTaskTableViewController
//*****************************************************
class MasterBuildTaskTableViewController : UITableViewController, NSFetchedResultsControllerDelegate {
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Master Build Tasks"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(DoAdd))
    }
    
    //***********
    //***** override func numberOfSections
    //***********
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    //***********
    //***** override func tableView numberOfRowsInSection
    //***********
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    //***********
    //***** override func tableView cellForRowAt
    //***********
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCell(withIdentifier: "MasterBuildTasksCellIdentifier", for: indexPath as IndexPath) as! MasterBuildTaskCell
        myCell.myTableVC = self
        
        //Access the Deployments Array and set the label values for display
        let myMBTForCell = fetchedResultsController.object(at: indexPath)
        //let myMBTForCell = myMasterBuildTasks[indexPath.row]
        configureCell(myCell,withMasterBuildTask : myMBTForCell)
        return myCell
    }
    
    //***********
    //***** @objc func DoDone
    //***********
    @objc func DoDone(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    //***********
    //***** @objc func DoAdd
    //***********
    @objc func DoAdd(_ sender: Any) {
        let context = self.fetchedResultsController.managedObjectContext
        let myMasterBuildTask = MasterBuildTask(context: context) // Link Task & Context
        myMasterBuildTask.name = "New Master Build Task"
        myMasterBuildTask.created = NSDate() as Date
        myMasterBuildTask.modified = myMasterBuildTask.created
        myMasterBuildTask.templatefile = ""
        myMasterBuildTask.templatefiletext = ""
        myMasterBuildTask.version = "1"

        // Save the context.
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //***********
    //***** func configureCell
    //***********
    func configureCell(_ theCell: MasterBuildTaskCell, withMasterBuildTask theMasterBuildTask: MasterBuildTask) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        theCell.mbtcreatedlabel.text = "Created: " + formatter.string(from: theMasterBuildTask.created!)
        theCell.mbtmodifiedlabel.text = "Modified: " + formatter.string(from: theMasterBuildTask.modified!)
        theCell.mbtnamelabel.text = theMasterBuildTask.name
    }
    
    //***********
    //***** override func prepare - Segues
    //***********
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTask" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination) as! MasterBuildTaskViewController
                controller.myMasterBuildTask = fetchedResultsController.object(at: indexPath)
            }
        }
    }
    
    //***********
    //***** var fetchedResultsController
    //***********
    var fetchedResultsController: NSFetchedResultsController<MasterBuildTask> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<MasterBuildTask> = MasterBuildTask.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "modified", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "MasterBuildTaskTableViewController")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    
    //***********
    //***** var _fetchedResultsController
    //***********
    var _fetchedResultsController: NSFetchedResultsController<MasterBuildTask>? = nil

    //***********
    //***** func controller
    //***********
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    //***********
    //***** func controller
    //***********
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            configureCell(tableView.cellForRow(at: indexPath!)! as! MasterBuildTaskCell, withMasterBuildTask: anObject as! MasterBuildTask)
        case .move:
            configureCell(tableView.cellForRow(at: indexPath!)! as! MasterBuildTaskCell, withMasterBuildTask: anObject as! MasterBuildTask)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    //***********
    //***** func controllerWillChangeContent
    //***********
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    //***********
    //***** func controllerDidChangeContent
    //***********
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}

//*****************************************************
//***** class MasterBuildTaskCell
//*****************************************************
class MasterBuildTaskCell : UITableViewCell{
    
    @IBOutlet weak var mbtmodifiedlabel: UILabel!
    @IBOutlet weak var mbtcreatedlabel: UILabel!
    @IBOutlet weak var mbtnamelabel: UILabel!
    var myTableVC: MasterBuildTaskTableViewController?
    
    //***********
    //***** override init
    //***********
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        SetUpViews()
    }
    //***********
    //***** required init?
    //***********
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //***********
    //***** func SetUpViews
    //***********
    func SetUpViews(){
    }
}

//**********************************************************************************************
//**********************************************************************************************
//***** MasterBuildTask
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class MasterBuildTaskViewController
//*****************************************************
class MasterBuildTaskViewController : UIViewController, NSFetchedResultsControllerDelegate {
    var myManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var myMasterBuildTask : MasterBuildTask!
    var myMasterBuildTask: MasterBuildTask? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var desctextentry: UITextField!
    @IBOutlet weak var vertextentry: UITextField!
    @IBOutlet weak var temtextentry: UITextView!
    
    //***********
    //***** func configureView
    //***********
    func configureView() {
        if let detail = myMasterBuildTask {
            nametextfield?.text = detail.name
            desctextentry?.text = detail.templatefile
            vertextentry?.text = detail.version
            temtextentry?.text = detail.templatefiletext
        }
    }
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Master Build Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(DoSave))
        configureView()
    }
    
    //***********
    //***** @objc func DoSave
    //***********
    @objc func DoSave(_ sender: Any) {
        let myMasterBuildTask = MasterBuildTask(context: myManagedObjectContext) // Link Task & Context
        myMasterBuildTask.name = nametextfield.text
        myMasterBuildTask.modified = NSDate() as Date
        myMasterBuildTask.templatefile = desctextentry.text
        myMasterBuildTask.templatefiletext = temtextentry.text
        myMasterBuildTask.version = vertextentry.text
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //self.dismiss(animated: false, completion: nil)
    }

}

//**********************************************************************************************
//**********************************************************************************************
//***** MasterBuildTask
//**********************************************************************************************
//**********************************************************************************************

//*****************************************************
//***** class MasterBuildTaskViewController
//*****************************************************
class MasterBuildTaskViewController : UIViewController, NSFetchedResultsControllerDelegate {
    var myManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var myMasterBuildTask : MasterBuildTask!
    var myMasterBuildTask: MasterBuildTask? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    @IBOutlet weak var nametextfield: UITextField!
    @IBOutlet weak var desctextentry: UITextField!
    @IBOutlet weak var vertextentry: UITextField!
    @IBOutlet weak var temtextentry: UITextView!
    
    //***********
    //***** func configureView
    //***********
    func configureView() {
        if let detail = myMasterBuildTask {
            nametextfield?.text = detail.name
            desctextentry?.text = detail.templatefile
            vertextentry?.text = detail.version
            temtextentry?.text = detail.templatefiletext
        }
    }
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Master Build Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(DoSave))
        configureView()
    }
    
    //***********
    //***** @objc func DoSave
    //***********
    @objc func DoSave(_ sender: Any) {
        let myMasterBuildTask = MasterBuildTask(context: myManagedObjectContext) // Link Task & Context
        myMasterBuildTask.name = nametextfield.text
        myMasterBuildTask.modified = NSDate() as Date
        myMasterBuildTask.templatefile = desctextentry.text
        myMasterBuildTask.templatefiletext = temtextentry.text
        myMasterBuildTask.version = vertextentry.text
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        //self.dismiss(animated: false, completion: nil)
    }
    
}

