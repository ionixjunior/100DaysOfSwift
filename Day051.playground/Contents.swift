let names = ["Jorge", "Samantha", "Louis", "Laura"]

let numberOfLetters = names.map { $0.count }
print(numberOfLetters)

let uppercasedNames = names.map { $0.uppercased() }
print(uppercasedNames)

let fullNames = ["Jorge Smith", "Samantha Johnson", "Louis Johnson", "Laura Williams"]

let johnsons = fullNames.filter { $0.contains("Johnson") }
print(johnsons)
