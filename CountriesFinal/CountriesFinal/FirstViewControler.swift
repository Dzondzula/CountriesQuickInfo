//
//  FirstViewControler.swift
//  CountriesFinal
//
//  Created by Nikola Andrijasevic on 13.10.21..
//

import UIKit

class FirstViewControler: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let cellSpacingHeight: CGFloat = 5
    let starter  = ["Countries","Saved","Challenge"]
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self//responsible for handeling interactions
        myTableView.dataSource = self
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.starter.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StartCell", for: indexPath)
         cell.layer.borderWidth = .leastNormalMagnitude
         cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
         cell.textLabel?.textAlignment = .center
         cell.backgroundColor = .blue
         
                 
         cell.layer.cornerRadius = 10
         cell.clipsToBounds = true
         
         cell.textLabel?.text = self.starter[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if ((cell.textLabel?.text = "Countries") != nil){
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CountriesList") as? CountriesViewController{
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
            }
        }
        }
        
    }

