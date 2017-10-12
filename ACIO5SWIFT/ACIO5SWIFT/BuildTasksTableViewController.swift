//
//  BuildTasksTableViewController
//  ACIO5SWIFT
//
//  Created by Charles Zillmann on 10/3/17.
//  Copyright © 2017 Charles Zillmann. All rights reserved.
//

import Foundation
import UIKit

//*****************************************************
//***** class BuildTasksTableViewController
//*****************************************************
class BuildTasksTableViewController : UITableViewController {
    
    var myBuildTasks = [String]()
    
    //***********
    //***** override func viewDidLoad
    //***********
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Build Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddABuildTask))
    }
    
    //***********
    //***** override func tableView
    //***********
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBuildTasks.count
    }
    
    //***********
    //***** override func tableView cellForRowAt
    //***********
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "BuildTasksCellIdentifier", for: indexPath as IndexPath) as! BuildTaskCell
        myCell.textLabel?.text = myBuildTasks[indexPath.row]
        myCell.detailTextLabel?.text = "Subtitle"
        myCell.myBuildTasksTableViewController = self
        return myCell
    }
    
    //***********
    //***** @objc func AddABuildTask
    //***********
    @objc func AddABuildTask() {
        self.myBuildTasks.append("New Build Task")
        self.tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
    }
}

//*****************************************************
//***** class BuildTaskCell
//*****************************************************
class BuildTaskCell : UITableViewCell{
    
    var myBuildTasksTableViewController: BuildTasksTableViewController?
    
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
