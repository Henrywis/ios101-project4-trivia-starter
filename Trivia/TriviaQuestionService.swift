//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Henry Alumona on 10/10/23.
//

import Foundation

class TriviaQuestionService {
    static func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]?) -> Void) {
        let apiUrl = "https://opentdb.com/api.php?amount=10"
        let url = URL(string: apiUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response")
                completion(nil)
                return
            }
            guard let data = data else {
                assertionFailure("Invalid response data")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let triviaResponse = try decoder.decode(TriviaResponse.self, from: data)
                let triviaQuestions = triviaResponse.results.map { result in
                    return TriviaQuestion(
                        category: result.category,
                        question: result.question,
                        correctAnswer: result.correctAnswer,
                        incorrectAnswers: result.incorrectAnswers
                    )
                }
                completion(triviaQuestions)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}
