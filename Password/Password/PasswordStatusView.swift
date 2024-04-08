//
//  PasswordStatusView.swift
//  Password
//
//  Created by Mykhailo Kotyk on 07.04.2024.
//

import UIKit

class PasswordStatusView : UIView {
    
    let stackView = UIStackView()
    
    let criteriaViewFirst = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let criteriaLabel = UILabel()
    let criteriaViewSecond = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let criteriaViewThird = PasswordCriteriaView(text: "lowercase (a-z)")
    let criteriaViewFour = PasswordCriteriaView(text: "digit (0-9)")
    let criteriaViewFive = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    private var shouldResetCriteria : Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize:  CGSize {
        return CGSize(width: 200, height: 220)
    }
}


extension PasswordStatusView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        
        criteriaViewFirst.translatesAutoresizingMaskIntoConstraints = false
//        criteriaViewFirst.isCriteriaMet = false
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        criteriaLabel.font = .preferredFont(forTextStyle: .subheadline)
        criteriaLabel.textColor = .secondaryLabel
        criteriaLabel.numberOfLines = 0
        criteriaLabel.lineBreakMode = .byWordWrapping
        criteriaLabel.textAlignment = .left
        
        criteriaLabel.attributedText = makeCriteriaMessage()
        
        criteriaViewSecond.translatesAutoresizingMaskIntoConstraints = false
//        criteriaViewSecond.isCriteriaMet = true
        criteriaViewThird.translatesAutoresizingMaskIntoConstraints = false
//        criteriaViewThird.isCriteriaMet = false
        criteriaViewFour.translatesAutoresizingMaskIntoConstraints = false
//        criteriaViewFour.isCriteriaMet = false
        criteriaViewFive.translatesAutoresizingMaskIntoConstraints = false
//        criteriaViewFive.isCriteriaMet = true
    }
    
    func layout() {
        
        stackView.addArrangedSubview(criteriaViewFirst)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(criteriaViewSecond)
        stackView.addArrangedSubview(criteriaViewThird)
        stackView.addArrangedSubview(criteriaViewFour)
        stackView.addArrangedSubview(criteriaViewFive)
        
        addSubview(stackView)
        
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2)
        ])
        
    }
    
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

        return attrText
    }
    
}

//MARK: actions

extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        
        if shouldResetCriteria {
            lengthAndNoSpaceMet
            ? criteriaViewFirst.isCriteriaMet = true
            : criteriaViewFirst.reset()
            
            uppercaseMet
            ? criteriaViewSecond.isCriteriaMet = true
            : criteriaViewSecond.reset()
            
            lowercaseMet
            ? criteriaViewThird.isCriteriaMet = true
            : criteriaViewThird.reset()
            
            digitMet
            ? criteriaViewFour.isCriteriaMet = true
            : criteriaViewFour.reset()
            
            specialCharacterMet
            ? criteriaViewFive.isCriteriaMet = true
            : criteriaViewFive.reset()
        }
    }
}
