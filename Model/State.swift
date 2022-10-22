//
//  State.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import Foundation

//Singleton Pattern to store data
class State {
  static let instance = State()
  var user = User()
  var quizzes: [Quiz]?
  var quiz_id: Int?
  var questions: [Question]?
  var question_index: Int?
  var options: [String]?
  var leaderboard: [User]?
  
  func wipe(){
    user = User()
    quizzes = nil
    quiz_id = nil
    questions = nil
    options = nil
    question_index = nil
    leaderboard = nil
  }
}
