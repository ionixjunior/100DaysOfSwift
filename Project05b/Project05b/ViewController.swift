import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    let currentWordKey = "currentWordKey"
    let usedWordsKey = "usedWordsKey"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(startGame))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        guard let currentWord = UserDefaults.standard.string(forKey: currentWordKey) else {
            startGame()
            return
        }
        guard let usedWords = UserDefaults.standard.stringArray(forKey: usedWordsKey) else {
            startGame()
            return
        }
        
        title = currentWord
        self.usedWords = usedWords
    }
    
    @objc func promptForAnswer() {
        let alert = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak alert] _ in
            guard let answer = alert?.textFields?.first?.text else { return }
            self?.submit(answer)
        }
        alert.addAction(submitAction)
        
        present(alert, animated: true)
    }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        if lowerAnswer.isEmpty {
            showError(title: "What do you mean?", message: "You need to insert a word.")
            return
        }
        
        if lowerAnswer.count < 3 {
            showError(title: "Short answer", message: "You need to specify an answer with a minimum of three letters.")
            return
        }
        
        if hasTheFirstLettersOfTheMainWord(word: lowerAnswer) {
            showError(title: "Try to use another answer", message: "Your answer can't start with the same letters as the main word.")
            return
        }
        
        if isPossible(word: lowerAnswer) == false {
            showError(title: "Impossible word", message: "This word can't be built.")
            return
        }
        
        if isOriginal(word: lowerAnswer) == false {
            showError(title: "Please, be original!", message: "You already used this word.")
            return
        }
        
        if isReal(word: lowerAnswer) == false {
            showError(title: "Incorrect word", message: "You need to insert only real words.")
            return
        }
        
        usedWords.insert(lowerAnswer, at: 0)
        UserDefaults.standard.set(usedWords, forKey: usedWordsKey)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func hasTheFirstLettersOfTheMainWord(word: String) -> Bool {
        guard let title = title?.lowercased() else { return false }
        return title.starts(with: word)
    }
    
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isOriginal(word: String) -> Bool {
        return usedWords.contains(word) == false
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func startGame() {
        let currentWord = allWords.randomElement()
        UserDefaults.standard.set(currentWord, forKey: currentWordKey)
        title = currentWord
        
        usedWords.removeAll(keepingCapacity: true)
        UserDefaults.standard.set(usedWords, forKey: usedWordsKey)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.update(text: usedWords[indexPath.row])
        return cell
    }
}

