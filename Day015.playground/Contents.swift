import UIKit

// review of trailing closures
func makeInterview(greetings: () -> Void,
                   questions: () -> Void,
                   finish: () -> Void) {
    greetings()
    questions()
    finish()
}

makeInterview() {
    print("Good morning, Samantha!")
} questions: {
    let questions = [
        "How are you?",
        "What do you think about software architecture?",
        "Do you know about SOLID principles?"
    ]
    
    for question in questions {
        print("* \(question)")
    }
} finish: {
    print("Thank you so much for your time!")
}
