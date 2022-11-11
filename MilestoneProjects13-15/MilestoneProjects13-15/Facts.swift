import UIKit

struct Facts: Codable {
    let capitalCity: String
    let officialLanguages: [OfficialLanguage]
    let size: Int
    let population: Int
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case capitalCity = "capital_city"
        case officialLanguages = "official_languages"
        case size
        case population
        case currency
    }
}
