import UIKit

class ViewController: UIViewController {
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
        view.addSubview(textFieldMaskedWord)

        typedLettersLabel = UILabel()
        typedLettersLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(typedLettersLabel)
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textFieldMaskedWord.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldMaskedWord.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            typedLettersLabel.topAnchor.constraint(equalTo: textFieldMaskedWord.bottomAnchor, constant: 20),
            typedLettersLabel.centerXAnchor.constraint(equalTo: textFieldMaskedWord.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game = HangmanGame()
        game.start(word: "developer")
        
        updateData()
    }
    
    private func updateData() {
        livesLabel.text = "Lives: \(game.getLives())"
        textFieldMaskedWord.text = game.getMaskedWord()
        typedLettersLabel.text = "Typed letters: \(game.getTypedLetters())"
    }
}

