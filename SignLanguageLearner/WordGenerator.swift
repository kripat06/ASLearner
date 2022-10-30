//
//  WordGenerator.swift
//  SignLanguageLearner
//
//  Created by admin on 10/20/22.
//

import Foundation
import SwiftUI

var currentWord: String = ""

//Used for buttons in LearnView.swift
enum Keys: String{
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case H = "H"
    case I = "I"
    case J = "J"
    case K = "K"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
    
    var buttonColor: Color {
        switch self{
        case nil:
            return Color("Button Color Pressed")
        default:
            return Color("Button Color")
        }
    }
}

var detectedLetter = DetectedLetter.shared
var iter:Int = 0

//Word Bank
let words = ["CAB", "BAD", "BONK", "BACK", "GEL"]

//Hanfles text changing for Practice View
func randomText() -> String {
    currentWord = words[Int(arc4random_uniform(UInt32(words.count)))]
    DetectedWord.shared.setGeneratedWord(word: currentWord)
    return currentWord
}

func checkWord(word:String = ""){
    let characters = word.map(String.init)
    if detectedLetter.detectedLetter == characters[iter] {
        print("correct")
    }
    else {
        print("incorrect")
    }
        
}
