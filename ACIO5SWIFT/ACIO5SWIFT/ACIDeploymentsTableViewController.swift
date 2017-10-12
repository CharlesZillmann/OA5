//
//  ACIDeploymentsTableViewController
//  ACIO5SWIFT
//
//  Created by Charles Zillmann on 10/3/17.
//  Copyright © 2017 Charles Zillmann. All rights reserved.
//

import Foundation
import UIKit
import CoreData

//*****************************************************
//***** class ACIDeploymentsTableViewController
//*****************************************************
class ACIDeploymentsTableViewController : UITableViewController {
    //Declare variables that will be managed by this view controller
    var myDeployments: [Deployment] = []
    
    //***********
    //***** override func viewWillAppear
    //***********
    //Handle any view setup prior to the view appearing
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //***********
    //***** override func tableView numberOfRowsInSection
    //***********
    //Return the correct number of rows for this table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDeployments.count
    }
    
    //***********
    //***** override func tableView cellForRowAt
    //***********
    //This function will be used to fetch a specific cell based on an index
    @IBOutlet weak var architecturelabel: UILabel!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = self.tableView.dequeueReusableCell(withIdentifier: "deploymentcellIdentifier", for: indexPath as IndexPath) as! ACIDeploymentsCell
        myCell.myTableVC = self
        
        //Access the Deployments Array and set the label values for display
        let myDepForCell = myDeployments[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        myCell.createdfieldlabel?.text = "Created: " + formatter.string(from: myDepForCell.created!)
        myCell.modifiedfieldlabel?.text = "Modified: " + formatter.string(from: myDepForCell.modified!)
        myCell.deploymentnamelabel?.text = myDepForCell.name
        myCell.namingconventionlabel?.text = myDepForCell.dtonc?.name
        myCell.architecturestandard?.text = myDepForCell.dtoas?.name

        return myCell
    }
    
    //***********
    //***** override func viewDidLoad
    //***********
    //Customize the view after it loads and before it is displayed
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ACI Deployments"
        
        //Create and Set the Left Bar Button to a "Gear" to indicate settings
        //adjusting the size as required
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSString(string: "\u{2699}\u{0000FE0E}") as String, style: .plain, target: self, action: #selector(DoSettings))
        let font = UIFont.systemFont(ofSize: 28)
        let attributes = [NSAttributedStringKey.font : font]
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
        
        //Create Button and Set the right bar button title as an Add
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddADeployment))
    }
    
    //***********
    //***** @objc func AddADeployment
    //***********
    //Add a deployment to the deployment list and insert a row in the table
    @objc func AddADeployment() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let myNewDep = Deployment(context: context) // Link Task & Context
        myNewDep.name = "New Deployment"
        myNewDep.dtonc = nil
        myNewDep.dtoas = nil
        myNewDep.created = NSDate() as Date
        myNewDep.modified = myNewDep.created
        self.myDeployments.insert(myNewDep, at: 0)
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    //***********
    //***** @objc func DoSettings()
    //***********
    @objc func DoSettings() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
    }
}

//*****************************************************
//***** class ACIDeploymentsCell
//*****************************************************
class ACIDeploymentsCell : UITableViewCell{
    @IBOutlet weak var createdfieldlabel: UILabel!
    @IBOutlet weak var modifiedfieldlabel: UILabel!
    @IBOutlet weak var deploymentnamelabel: UILabel!
    @IBOutlet weak var namingconventionlabel: UILabel!
    @IBOutlet weak var architecturestandard: UILabel!
    
    var myTableVC: ACIDeploymentsTableViewController?
    
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

//*****************************************************
//***** class DeploymentSettingsViewController
//*****************************************************
class DeploymentSettingsViewController : UIViewController {
    @IBOutlet weak var namefieldtext: UITextField!
    @IBOutlet weak var cancel: UIBarButtonItem!
    @IBOutlet weak var customize: UIBarButtonItem!
    @IBOutlet weak var save: UIBarButtonItem!
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let myDeployment = Deployment(context: context) // Link Task & Context
        namefieldtext.text = myDeployment.name
    }
    
    //***********
    //***** @IBAction func cancel
    //***********
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //***********
    //***** @IBAction func customize
    //***********
    @IBAction func customize(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //***********
    //***** @IBAction func save
    //***********
    @IBAction func save(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let myDeployment = Deployment(context: context) // Link Task & Context
        myDeployment.name = namefieldtext.text!
        //myDeployment.namingconvention = nil
        //myDeployment.architecturestandard = nil
        myDeployment.modified = NSDate() as Date
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.dismiss(animated: false, completion: nil)
    }
}
