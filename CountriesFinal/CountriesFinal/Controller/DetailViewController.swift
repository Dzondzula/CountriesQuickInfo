//
//  DetailViewController.swift
//  CountriesFinal
//
//  Created by Nikola Andrijasevic on 14.10.21..
//
import WebKit
import UIKit
import CoreLocation
import MapKit
class DetailViewController: UIViewController,WKNavigationDelegate {

    
    var webView = WKWebView()
    var detailItem : CountriesFinal?
    var spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open in maps", style: .plain, target: self, action: #selector(openInMaps))
        webView.frame = CGRect(x: 80, y: 150, width: 250, height: 150)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleAspectFit
        self.view.addSubview(webView)
        
        self.webView.addSubview(self.spinner)//first we need to add subview then make center or something
        spinner.center = CGPoint(x: webView.bounds.width / 2, y: webView.bounds.height / 2)
     
        webView.navigationDelegate = self
        spinner.startAnimating()
        spinner.hidesWhenStopped = true


        guard let detailItem = detailItem else {
            return
        }
        let lowerCode = detailItem.code.lowercased()
        let pictureURL = URL(string: "https://flagpedia.net/data/flags/w580/\(lowerCode).png")!

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        //label1.backgroundColor =
        if detailItem.code == "AF" && detailItem.language.name == "France"{
        label1.text = "Country: \(detailItem.name) (Colony of France)"
        } else {
            label1.text = "Country: \(detailItem.name)"
        }
        label1.sizeToFit()
        
        var continent: String = detailItem.region
        switch continent{
        case "AF":
            continent = "Africa"
        case "NA":
            continent = "North America"
        case "OC":
            continent = "Oceania"
        case "AN":
            continent = "Antartica"
        case "AS":
            continent = "Asia"
        case "EU":
            continent = "Europe"
        case "SA":
            continent = "South America"
        default:
            print("Cant access continent")
        }
        
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        //label2.backgroundColor =
        label2.text = "Capital city: \(detailItem.capital)"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        //label3.backgroundColor =
        label3.text = "Continent: \(String(describing: continent))"
        
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        //label4.backgroundColor =
        label4.text = "Currency: \(detailItem.currency.code)"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        //label5.backgroundColor =
        label5.text = "Language: \(detailItem.language.name)"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        var previous: UILabel?
        for label in [label1,label2,label3,label4,label5]{
            label.backgroundColor = .white
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 5).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            label.heightAnchor.constraint(equalToConstant: 50).isActive = true
           
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
                //if we have a previous label, make the top anchor of this label equal to the bottom anchor of the previous label plus 10,(gornja Anchor jednaka je prehodnoj dodnjoj Anchor + 10pt razmak
            }else{
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 260).isActive = true//if we add an else block we can push the first label away from the top of the safe area, so it doesn’t sit under the notch, like this.(ili je TopAnchor = safeArea + 0pt
            }
          previous = label
        }
            
        
        
        webView.load(URLRequest(url: pictureURL))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        spinner.stopAnimating()
        print("Unable to load flag")
    }
    @objc func openInMaps(){//Copy paste
        CLGeocoder().geocodeAddressString((detailItem?.name)!, completionHandler: {(placemarks, error) in

                if error != nil {
                    print("")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    let coordinate = CLLocationCoordinate2DMake(coords.latitude,coords.longitude)
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                    mapItem.name = "Target location"
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])

                }
            })
        }


}
