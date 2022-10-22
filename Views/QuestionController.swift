//
//  QuestionController.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import UIKit
import Toast

class QuestionView : UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var questionLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  
  var question_id: Int?
  var selected = -1
  var options: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let question = State.instance.questions![State.instance.question_index!]
    question_id = question.id
    questionLabel.text = question.question
    options = question.options!.components(separatedBy: ",")
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  
  @IBAction func SubmitAction() {
    guard selected != -1 else {
      self.view.makeToast("Please select an answer", duration: 2.0, position: .bottom)
      return
    }
    AnswerQuestion(key: State.instance.user.key!, question_id: question_id!, response: selected) {result in
      switch result.code {
      case .success:
        self.view.makeToast(result.payload as? String, duration: 2.0, position: .bottom)
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellOption", for: indexPath)
    let option = options?[indexPath.row]
    var config = cell.defaultContentConfiguration()
    config.text = "Option \(indexPath.row + 1): "
    config.secondaryText = "\(option ?? "ERROR")"
    cell.contentConfiguration = config
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selected = indexPath.row + 1
  }
  
}
