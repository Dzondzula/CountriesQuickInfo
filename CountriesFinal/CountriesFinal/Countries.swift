
import UIKit
import Foundation



struct CountriesFinal: Decodable{
    var name: String
    var code: String
    var capital: String
    var region: String
    var currency: CurrencyCode
    var language : Language
    var flag : String
}

struct Language : Decodable{
    var name : String
}

struct CurrencyCode : Decodable{
    var code: String
    var name: String
}

