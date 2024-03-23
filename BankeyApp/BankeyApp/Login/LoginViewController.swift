//
//  ViewController.swift
//  BankeyApp
//
//  Created by Mykhailo Kotyk on 22.03.2024.
//

import UIKit

protocol LoginViewControllerDelegate : AnyObject {
    
    func didLogin()
    
}

protocol LogoutDelegate : AnyObject {
    
   func didLogout()
    
}

class LoginViewController: UIViewController {

    
    let loginView = LoginView()
   
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    let appNameLabel = UILabel()
    let descriptionLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        style()
        layout()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }

}

extension LoginViewController {
    private func style() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.textAlignment = .center
        appNameLabel.font = .systemFont(ofSize: 24)
        appNameLabel.textColor = .black
        appNameLabel.text = "Bankey"
        appNameLabel.numberOfLines = 0
        appNameLabel.isHidden = false
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .black
        descriptionLabel.text = "Your premium source for all things banking"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.isHidden = false
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        view.addSubview(appNameLabel)
        view.addSubview(descriptionLabel)
        
        //LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        //Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: signInButton.trailingAnchor, multiplier: 1)
        ])
        
        //Error label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor)
        ])
        
        //Description label
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        //AppName label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 3),
            appNameLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appNameLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
     
    }
}

//MARK: Actions
extension LoginViewController  {
    @objc func signInTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password cannot be blank")
            return
        }
        
        if username == "a" && password == "1" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message : String ){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}
