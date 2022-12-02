import UIKit

let name = "Samantha"

for letter in name {
    print("The letter is \(letter)")
}

let letterM = name[name.index(name.startIndex, offsetBy: 2)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
    
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

let letterMUsingExtension = name[2]


let password = "12345"
password.hasPrefix("123")
password.hasSuffix("456")
let passwordWithoutPrefix = password.deletingPrefix("123")
let passwordWithoutSuffix = password.deletingSuffix("345")


let lorenIpsun = "lorem ipsum dolor sit amet, consectetur adipiscing elit."
print(lorenIpsun.capitalized)
print(lorenIpsun.capitalizedFirst)

lorenIpsun.contains("ipsum")

let words = ["test", "dolor"]
words.contains(where: lorenIpsun.contains)


let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]
let attributedString = NSAttributedString(string: lorenIpsun, attributes: attributes)

let mutableAttributedString = NSMutableAttributedString(string: lorenIpsun)
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 10), range: NSRange(location: 0, length: 5))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 6, length: 5))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 30), range: NSRange(location: 12, length: 5))
mutableAttributedString.addAttribute(.backgroundColor, value: UIColor.red, range: NSRange(location: 12, length: 5))
mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 12, length: 5))
mutableAttributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: NSRange(location: 22, length: 4))
mutableAttributedString.addAttribute(.link, value: UIColor.link, range: NSRange(location: 22, length: 4))
