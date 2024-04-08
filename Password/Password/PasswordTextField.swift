//
//  PasswordTextField.swift
//  Password
//
//  Created by Mykhailo Kotyk on 06.04.2024.
//

import UIKit

protocol PasswordTextFieldDelegate : AnyObject {
    func editingChanged(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    
    let textField = UITextField()
    let placeHolderText: String
    let eyeButton = UIButton(type: .custom)
    let deviderView = UIView()
    let errorLabel = UILabel()
    let errorLabelText : String
    
    weak var delegate: PasswordTextFieldDelegate?
    
    init(placeHolderText: String, errorLabelText: String = "Your password must meet the requirements below") {
        self.placeHolderText = placeHolderText
        self.errorLabelText = errorLabelText
        super.init(frame: .zero)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 55)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .systemOrange
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false //true
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
        //deviderVIew
        
        deviderView.translatesAutoresizingMaskIntoConstraints = false
        deviderView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.text = errorLabelText
        errorLabel.textAlignment = .left
//        errorLabel.minimumScaleFactor = 0.8
//        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.numberOfLines = 0
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.isHidden = true
//        errorLabel.sizeToFit()
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(deviderView)
        addSubview(errorLabel)
        //lockimageview
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
        ])
        
        //textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
            
        ])
        
        //eyeButton
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: eyeButton.trailingAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
        
        //deviderView
        NSLayoutConstraint.activate([
            deviderView.heightAnchor.constraint(equalToConstant: 1),
            deviderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            deviderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            deviderView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1)
        ])
        
        //errorLabel
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo:  deviderView.bottomAnchor, constant: 4),
//            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier:  1),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
//        errorLabel.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
    }
}


//MARK: objc func

extension PasswordTextField {
    @objc func togglePasswordView() {
        
        eyeButton.isSelected.toggle()
        textField.isSecureTextEntry.toggle()
        print("DEBUG: togglePasswordView touch ")
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
            
        }
        delegate?.editingChanged(self)
    }
}

//MARK:

extension PasswordTextField : UITextFieldDelegate {
    
}
