//
//  QuizzesController.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import UIKit
import Toast
import XCTest

class QuizzesView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    FetchQuizzes() {result in
      switch result.code {
      case .success:
        let quizzes = result.payload as? [Quiz]
        State.instance.quizzes = quizzes
        self.tableView.reloadData()
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return State.instance.quizzes?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellQuiz", for: indexPath)
    let quiz = State.instance.quizzes?[indexPath.row]
    var config = cell.defaultContentConfiguration()
    config.text = "\(quiz?.title ?? "ERROR")"
    config.secondaryText = "\(quiz?.questions ?? 0) question(s)"
    cell.contentConfiguration = config
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "selectQuiz":
      if let row = tableView.indexPathForSelectedRow?.row {
        let quiz = State.instance.quizzes![row]
        let questionsView = segue.destination as! QuestionsView
        State.instance.quiz_id = quiz.id
        questionsView.navigationItem.title = quiz.title
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
}
