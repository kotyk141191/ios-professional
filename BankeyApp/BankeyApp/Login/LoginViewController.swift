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
    
    //animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
        appNameLabel.alpha = 0
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 18)
        descriptionLabel.textColor = .black
        descriptionLabel.text = "Your premium source for all things banking"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.isHidden = false
        descriptionLabel.alpha = 0
    }
    
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        view.addSubview(appNameLabel)
        view.addSubview(descriptionLabel)
        
        
        //Description label
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 2),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
         subtitleLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
         subtitleLeadingAnchor?.isActive = true
        //AppName label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 3),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        titleLeadingAnchor = appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
       
        
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
        
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / password cannot be blank")
//            return
//        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username / password")
        }
    }
    
    private func configureView(withMessage message : String ){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0,10,-10,10,0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
}

//MARK: - Animations

extension LoginViewController {
    private func animate() {
        
        let duration = 2.0
        
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 1)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.appNameLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 1)
        
        let animator4 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.descriptionLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator4.startAnimation(afterDelay: 1)
    }
}
