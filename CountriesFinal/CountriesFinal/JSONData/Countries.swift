
import UIKit
import Foundation



struct CountriesFinal: Codable{
    var name: String
    var code: String
    var capital: String
    var region: String
    var currency: CurrencyCode
    var language : Language
    var flag : String
}

struct Language : Codable{
    var name : String
}

struct CurrencyCode : Codable{
    var code: String
    var name: String
}

