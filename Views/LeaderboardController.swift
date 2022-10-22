//
//  LeaderboardView.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import UIKit
import Toast

class LeaderboardView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    FetchLeaderBoard() {result in
      switch result.code {
      case .success:
        let leaderboard = result.payload as? [User]
        State.instance.leaderboard = leaderboard
        self.tableView.reloadData()
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellUser", for: indexPath)
    let user = State.instance.leaderboard?[indexPath.row]
    var config = cell.defaultContentConfiguration()
    config.text = "\(indexPath.row + 1): \(user?.name ?? "ERROR") "
    config.secondaryText = "Score: \(user?.score ?? 0) - Answered: \(user?.answered ?? 0)"
    cell.contentConfiguration = config
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return State.instance.leaderboard?.count ?? 0
  }
}
