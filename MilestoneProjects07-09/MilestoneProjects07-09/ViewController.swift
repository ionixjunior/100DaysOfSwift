import UIKit

class ViewController: UIViewController {
    private var livesLabel: UILabel!
    private var textFieldMaskedWord: UITextField!
    private var typedLettersLabel: UILabel!

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
        view.addSubview(typedLettersLabel)
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textFieldMaskedWord.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldMaskedWord.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        livesLabel.text = "Lives: "
        textFieldMaskedWord.text = "_ e _"
        typedLettersLabel.text = "Typed letters: a - e"
    }


}

