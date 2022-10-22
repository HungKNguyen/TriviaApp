//
//  QuestionsController.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import UIKit
import Toast

class QuestionsView: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    FetchQuestions(quiz_id: State.instance.quiz_id!) {result in
      switch result.code {
      case .success:
        let questions = result.payload as? [Question]
        State.instance.questions = questions
        self.tableView.reloadData()
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return State.instance.questions?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellQuestion", for: indexPath)
    let question = State.instance.questions?[indexPath.row]
    var config = cell.defaultContentConfiguration()
    config.text = "Question \(indexPath.row + 1)"
    config.secondaryText = "\(question?.question ?? "ERROR")"
    cell.contentConfiguration = config
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "selectQuestion":
      if let row = tableView.indexPathForSelectedRow?.row {
        State.instance.question_index = row
      }
    default:
      preconditionFailure("Unexpected segue identifier.")
    }
  }
}
