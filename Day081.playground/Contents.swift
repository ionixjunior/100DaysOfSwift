import Foundation

extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            return self
        }
        
        return prefix + self
    }
    
    var isNumeric: Bool {
        for letter in self {
            if letter.isNumber == false {
                return false
            }
        }
        
        return true
    }
    
    var lines: Array<String> {
        return self.components(separatedBy: "\n")
    }
}

"dislike".withPrefix("dis")
"like".withPrefix("dis")


"teste".isNumeric
"te1te".isNumeric
"123a".isNumeric
"123".isNumeric


"""
loren
""".lines

"""
loren
ipsun
""".lines

"""
loren
ipsun
dollor
""".lines
