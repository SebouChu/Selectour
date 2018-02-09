//
//  DealsViewController.swift
//  Selectour
//
//  Created by Sébastien Gaya on 08/02/2018.
//  Copyright © 2018 Sébastien Gaya. All rights reserved.
//

import UIKit

class DealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dealsTableView: UITableView!
    var activities = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dealsTableView.separatorStyle = .none
        loadActivities()
        
        dealsTableView.delegate = self
        dealsTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func menuBtnPressed(_ sender: UIButton) {
        let menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        menuVC?.currentIndex = 1
        self.present(menuVC!, animated: true, completion: nil)
    }
    
    func loadActivities() {
        let activity1 = Activity(name: "Escalade du Corcovado", imageName: "activity1")
        activities.append(activity1)
        let activity2 = Activity(name: "Kayak sur l'Amazone", imageName: "activity2")
        activities.append(activity2)
        let activity3 = Activity(name: "Visite guidée à vélo", imageName: "activity3")
        activities.append(activity3)
        let activity4 = Activity(name: "Dégustations locales", imageName: "activity4")
        activities.append(activity4)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealsTableViewCell") as? DealsTableViewCell else {
            fatalError("Could not instantiate cell")
        }
        let currentActivity = activities[indexPath.row]
        cell.activityLabel.text = currentActivity.name
        cell.coverImageView.image = currentActivity.image
        
        return cell
    }
    
}
