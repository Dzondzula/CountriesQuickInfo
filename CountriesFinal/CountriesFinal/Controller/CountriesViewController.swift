
import UIKit
import WebKit
import Alamofire

class CountriesViewController: UITableViewController,UISearchBarDelegate{
    
    var countriess = [CountriesFinal] ()
    var state = [CountriesFinal] ()
  
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBar.placeholder = "Search countries.."
        //searchBar.scopeButtonTitles = ["All","Europe", "Asia", "Africa","Oceania", "America"]
        searchBar.delegate = self
//        performSelector(inBackground: #selector(fetchJSON), with: nil)
          
        let cqiimage = UIImageView(image: UIImage(named: "CQI"))
        
        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.navigationItem.titleView = cqiimage
        
        performSelector(inBackground: #selector(loadFlex), with: nil)
         
    }
@objc func loadFlex(){
    let urlString = "https://raw.githubusercontent.com/Dzondzula/Dzondzula.github.io/main/Globus.json"

      AF.request(urlString,method: .get).validate().responseDecodable(of: Country.self) { [weak self] responseData in
          guard let self = self else {return}
          guard let countries = responseData.value else {return}
          self.countriess = countries.countries
          self.state = self.countriess
          DispatchQueue.main.async {
              
          self.tableView.reloadData()
          }
      }
}
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       state.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let countri = state[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = countri.name
        cell.contentConfiguration = content
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
            vc.detailItem = state[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        state = countriess
        if searchText == "" {
            state = countriess
        } else{
        state = countriess.filter{
            $0.name.lowercased().contains(searchText.lowercased())
        }
        }
        self.tableView.reloadData()
        
        
    }
}


