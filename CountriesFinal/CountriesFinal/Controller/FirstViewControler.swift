//
//  FirstViewControler.swift
//  CountriesFinal
//
//  Created by Nikola Andrijasevic on 13.10.21..
//

import UIKit

class FirstViewControler: UIViewController,UITableViewDelegate,UITableViewDataSource,UNUserNotificationCenterDelegate {
    
    let starter  = ["Countries","Challenge"]
    
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    var counter = 0
 
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerLocal()
        setWeekDay()
        
        backgroundImage.image = UIImage(named: "WorldMap.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
       
        
        
        myTableView.delegate = self//responsible for handeling interactions
        myTableView.dataSource = self
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 210, height: 80))
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            
            
            let attrs = [NSAttributedString.Key.font: UIFont(name: "Georgia", size: 20)!,NSAttributedString.Key.paragraphStyle: paragraphStyle,NSAttributedString.Key.foregroundColor: UIColor.white]
            
            let string = "CountriesQuickInfo"
            string.draw(with: CGRect(x: 5, y: 35, width: 200, height: 70), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        imageView.image = img
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.starter.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
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
         cell.backgroundColor = .init(white: 1, alpha: 0.3)
         cell.textLabel?.textColor = .white
         cell.textLabel?.font = UIFont(name: "Marker Felt", size: 25)
             
         cell.layer.cornerRadius = 10
         cell.clipsToBounds = true
         
         cell.textLabel?.text = self.starter[indexPath.section]
         
         
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if cell.textLabel?.text == "Countries" {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "CountriesList") as? CountriesViewController{
                
            navigationController?.pushViewController(vc, animated: true)
            }
        } else if cell.textLabel?.text == "Challenge" && counter % 2 == 0{
            let vc = Challenge()
                navigationController?.pushViewController(vc, animated: true)
            counter += 1
        } else {
            Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(counterPlus), userInfo: nil, repeats: false)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        }
    @objc func counterPlus(){
        counter += 1
    }
    
    func registerLocal(){
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]){
            (granted, error) in
            if granted{
                print("Have premmision")
            } else {
                print("oops")
            }
        }
    }
    
    func scheduleLocal(for weekday: Int){
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        
        let content = UNMutableNotificationContent()
        content.title = "What is the capital of"
        content.body = "Check if you don't know"
        content.categoryIdentifier = "alert"
        content.sound = UNNotificationSound.default
        
        let dateComponent = setDate(at: 10, and: 30, on: weekday)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        //set the delegate property of the user notification center to be self, meaning that any alert-based messages that get sent will be routed to our view controller to be handled.
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Check", options: .foreground)
        let category = UNNotificationCategory(identifier: "alert", actions: [show], intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier{
        case UNNotificationDefaultActionIdentifier:
            print("Default")
            
        case "show":
            let vc  = CountriesViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
        completionHandler()
    }
    
    
    func setWeekDay(){
        for weekday in 1...7{
            scheduleLocal(for: weekday)
        }
    }
    
    func setDate(at hours: Int?, and minutes: Int?, on weekday: Int?) -> DateComponents{
        var dateComp = DateComponents()
        dateComp.hour = hours
        dateComp.minute = minutes
        dateComp.weekday = weekday
        
        return dateComp
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
        
    }

