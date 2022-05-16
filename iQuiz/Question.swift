//
//  Question.swift
//  iQuiz
//
//  Created by Henry Bao on 5/16/22.
//

import Foundation

class Question {
    
    var text: String
    var answer: Int
    var choices: Array<String>
    
    init(text: String, answer: Int, choices: Array<String>) {
        self.text = text
        self.answer = answer
        self.choices = choices
    }
}
