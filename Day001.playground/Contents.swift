import UIKit

// strings
var description = "You have 1 message"
description = "You have 2 messages"

// int
var numberOfMessages = 10

// int can be used with underscore as thousands separator
var balance = 10_000_000

// multi-line string with line break
var emailContent = """
Hello, John!

My name is Samantha and I have an excellent opportunity to you to work in our COBOL team!

Are you evaluating other opportunities right now?
"""

// multi-line string without line break
var bigContent = """
This is\
a very "large"\
content without line breaks\
when I break the line into editor.
"""

// double
var pi = 3.14

// boolean
var isValid = true

// interpolation
var johnsDescription = "My name is John, I have \(numberOfMessages) unread messages, and I know the PI starts with \(pi)."

// constant
let mainColorOfDarkTheme = "black"

// type annotations
var name: String = "John"
var nickname: String
nickname = "john30"
var age: Int = 30
var temperature: Double = 19
var isMarried: Bool = true
