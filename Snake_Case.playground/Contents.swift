import Foundation

let testCase: [String] = [
    "Product",
    "SpecialGuest",
    "Donald E. Knuth",
    "PRODUCT",
    ""
]

let testSnakeCase: [String] = [
    "Donald_A",
    "donald_a_e_kIm",
    "___97214-123A84_AbBcde_eKa",
    "aAbBCc______edfe",
    "aAbBCc____edfe",
    "______aAbBCc____edfe____",
    "_abcd_def_ef_",
    "abd_doi_oij.**&&&"
]

func convertingToSnakeCase(from text: String) -> String {
    let capitalizedLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let lowercasedLetters = "abcdefghijklmnopqrstuvwxyz"
    let underScore = "_"
    let allowedLetters = capitalizedLetters + lowercasedLetters + underScore
    
    var lettersOnlyText: String = ""
    
    text.forEach {
        guard allowedLetters.contains($0) else { return }
        
        let letterToAppend = capitalizedLetters.contains($0) ? "_".appending(String($0)) : String($0)
        lettersOnlyText.append(letterToAppend)
    }
    
    while lettersOnlyText.contains("__") {
        lettersOnlyText = lettersOnlyText.replacingOccurrences(of: "__", with: "_")
    }
    
    return lettersOnlyText.trimmingCharacters(in: .punctuationCharacters).lowercased()
}

func runTest() {
    print("Regular Test")
    testCase.forEach {
        let convertedText = convertingToSnakeCase(from: $0)
        print("| \($0) | \(convertedText) |")
    }
    
    print("\n********************\n")
    
    print("Snake Pattern Test")
    testSnakeCase.forEach {
        let convertedText = convertingToSnakeCase(from: $0)
        print("| \($0) | \(convertedText) |")
    }
}

runTest()
