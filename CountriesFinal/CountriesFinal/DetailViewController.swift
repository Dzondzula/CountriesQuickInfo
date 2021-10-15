//
//  DetailViewController.swift
//  CountriesFinal
//
//  Created by Nikola Andrijasevic on 14.10.21..
//
import WebKit
import UIKit

class DetailViewController: UIViewController,WKNavigationDelegate {
//    var webView : WKWebView = {
//        let view = WKWebView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    var webView = WKWebView()
    var detailItem : CountriesFinal?
    var spinner = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.frame = CGRect(x: webView.frame.width / 2, y: webView.frame.height / 2, width: 10, height: 10)
        webView.addSubview(spinner)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        webView.backgroundColor = .blue
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        
        webView.frame = CGRect(x: 125, y: 150, width: 250, height: 150)
        webView.layer.borderWidth = 5
        webView.layer.borderColor = UIColor.red.cgColor

        webView.contentMode = .scaleAspectFit
        webView.backgroundColor = .blue

        self.view.addSubview(webView)
        
        guard let detailItem = detailItem else {
            return
        }
        let pictureURL = URL(string: detailItem.flag)!

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        //label1.backgroundColor =
        label1.text = detailItem.name
        label1.sizeToFit()
        
        var continent: String? = detailItem.region
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
        label3.text = continent
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        //label4.backgroundColor =
        label4.text = detailItem.currency.code
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        //label5.backgroundColor =
        label5.text = detailItem.language.name
        label5.sizeToFit()
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        var previous: UILabel?
        for label in [label1,label2,label3,label4,label5]{
            
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
    


}
