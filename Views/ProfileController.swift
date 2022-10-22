//
//  ProfileView.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 12/10/2022.
//

import UIKit
import Toast

class ProfileView: UIViewController {
  
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var APIKeyLabel: UILabel!
  @IBOutlet var scoreLabel: UILabel!
  @IBOutlet var answeredLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    usernameLabel.text = State.instance.user.name
    APIKeyLabel.text = State.instance.user.key
    FetchUserScore(key: State.instance.user.key!) {result in
      switch result.code {
      case .success:
        let user = result.payload as? User
        State.instance.user.score = user?.score
        State.instance.user.answered = user?.answered
        self.scoreLabel.text = "\(State.instance.user.score ?? 0)"
        self.answeredLabel.text = "\(State.instance.user.answered ?? 0)"
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  @IBAction func LogoutAction() {
    DeleteUser() {result in
      switch result.code {
      case .success:
        State.instance.wipe()
        self.performSegue(withIdentifier: "logout", sender: self)
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  
}
