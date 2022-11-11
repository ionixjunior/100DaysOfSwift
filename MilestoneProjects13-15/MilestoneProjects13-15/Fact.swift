import UIKit

struct Fact: Codable {
    let capitalCity: String
    let officialLanguages: [OfficialLanguage]
    let size: Int
    let population: Int
    let currency: String
}
