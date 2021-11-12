
import UIKit
import WebKit
class CountriesViewController: UITableViewController,UISearchBarDelegate{
   
    var countriess = [CountriesFinal] ()
    var state = [CountriesFinal] ()
  
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    weak var delegate : FirstViewControler!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        searchBar.placeholder = "Search countries.."
        searchBar.scopeButtonTitles = ["All","Europe", "Asia", "Africa","Oceania", "America"]
        searchBar.delegate = self
        performSelector(inBackground: #selector(fetchJSON), with: nil)
          
        let cqiimage = UIImageView(image: UIImage(named: "CQI"))
    
        self.navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.navigationItem.titleView = cqiimage
      
    }
        @objc func fetchJSON(){
        let session = URLSession.shared
        let urlString = "https://raw.githubusercontent.com/Dzondzula/Dzondzula.github.io/main/Globus.json"
        //"ttp://api.countrylayer.com/v2/all?access_key=88e5f402e6864cc63ff8378ee100f32b"
    let url = URL(string:urlString)!
        //note that we’re assigning the return value of dataTask(with:completionHandler:) to the task constant
        // completion handler is a closure that’s executed when the request completes, so when a response has returned from the webserver. This can be any kind of response, including errors, timeouts, 404s, and actual JSON data.
        //closure has three parameters: the response Data object, a URLResponse object, and an Error object. All of these closure parameters are optionals, so they can be nil.
            DispatchQueue.global(qos: .userInitiated).async {
                [self] in
            //Data tasks send and receive data with URLSessionDataTask, by using NSData objects. They’re the most common for webservice requests, for example when working with JSON.
                session.dataTask(with: url) {[self]data,response,error in
            if let data = data {
                if let decodedResponse = try?
                    JSONDecoder().decode(Country.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        countriess = decodedResponse.countries
                        state = countriess
                        
                        tableView.reloadData()
                    }
                    // everything is good, so we can exit
                    return
                }
            }
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        }
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       state.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let countri = state[indexPath.row]
        
        cell.textLabel?.text = countri.name
        
        
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


