import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    private var livesLabel: UILabel!
    private var textFieldMaskedWord: UITextField!
    private var typedLettersLabel: UILabel!
    private var game: HangmanGame!

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        livesLabel = UILabel()
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .right
        view.addSubview(livesLabel)
        
        textFieldMaskedWord = UITextField()
        textFieldMaskedWord.translatesAutoresizingMaskIntoConstraints = false
        textFieldMaskedWord.font = UIFont.systemFont(ofSize: 40)
        textFieldMaskedWord.addTarget(self, action: #selector(letterTyped), for: .editingChanged)
        textFieldMaskedWord.delegate = self
        view.addSubview(textFieldMaskedWord)

        typedLettersLabel = UILabel()
        typedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        typedLettersLabel.numberOfLines = 0
        typedLettersLabel.textAlignment = .center
        view.addSubview(typedLettersLabel)
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textFieldMaskedWord.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldMaskedWord.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            typedLettersLabel.topAnchor.constraint(equalTo: textFieldMaskedWord.bottomAnchor, constant: 20),
            typedLettersLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            typedLettersLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = HangmanGame()
        startGame()
        
        updateData()
    }
    
    private func startGame() {
        game.start(word: "developer")
    }
    
    private func updateData() {
        livesLabel.text = "Lives: \(game.getLives())"
        textFieldMaskedWord.text = game.getMaskedWord()
        typedLettersLabel.text = "Typed letters: \(game.getTypedLetters())"
    }
    
    @objc private func letterTyped() {
        textFieldMaskedWord.text = game.getMaskedWord()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let thisLetterExists = game.type(letter: string)
        updateData()
        
        if thisLetterExists == false {
            if game.getLives() == 0 {
                let alert = UIAlertController(title: "Game over", message: "Your lives is over. Please, try again!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default) {
                    [weak self] _ in
                    self?.startGame()
                    self?.updateData()
                })
                present(alert, animated: true)
            } else {
                let alert = UIAlertController(title: "Letter not found", message: "The letter \(string) does not exists in the word.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Continue", style: .default))
                present(alert, animated: true)
            }
        }
        
        return true
    }
}

