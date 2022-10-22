//
//  ViewController.swift
//  TriviaApp
//
//  Created by Hung K Nguyen on 10/10/2022.
//

import UIKit
import Toast

class LoginView: UIViewController {
  
  @IBOutlet var usernameField: UITextField!
  @IBOutlet var passwordField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    LoadUser() {result in
      if result.code == .success {
        let user = result.payload as? User
        self.usernameField.text = user?.name
        self.passwordField.text = user?.password
        self.LoginAction()
      }
    }
  }
  
  func TextFieldValidation() -> Bool {
    guard usernameField.text != nil else {
      self.view.makeToast("Please enter in username", duration: 2.0, position: .bottom)
      return false
    }
    guard passwordField.text != nil else {
      self.view.makeToast("Please enter in password", duration: 2.0, position: .bottom)
      return false
    }
    return true
  }
  
  @IBAction func LoginAction() {
    guard TextFieldValidation() else {
      return
    }
    State.instance.user.name = usernameField.text!
    State.instance.user.password = passwordField.text!
    LogIn(username: usernameField.text!, password: passwordField.text!) {result in
      switch result.code {
      case .success:
        State.instance.user.key = result.payload as? String
        self.performSegue(withIdentifier: "login", sender: self)
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  @IBAction func SignUpAction() {
    guard TextFieldValidation() else {
      return
    }
    State.instance.user.name = usernameField.text!
    State.instance.user.password = passwordField.text!
    SignUp(username: usernameField.text!, password: passwordField.text!) {result in
      switch result.code {
      case .success:
        State.instance.user.key = result.payload as? String
        self.performSegue(withIdentifier: "login", sender: self)
      case .failure:
        self.view.makeToast(result.error ?? "Unknown error.", duration: 2.0, position: .bottom)
      }
    }
  }
  
  
  
  @IBAction func dismissKeyboard(_ sender : UITapGestureRecognizer) {
    view.endEditing(true)
  }
}

