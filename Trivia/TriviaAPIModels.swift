//
//  TriviaAPIModels.swift
//  Trivia
//
//  Created by Henry Alumona on 10/10/23.
//

import Foundation


struct TriviaResponse: Codable {
    let results: [TriviaAPIQuestion]
}

struct TriviaAPIQuestion: Codable {
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}
