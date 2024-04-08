//
//  ViewController.swift
//  InlineTextFieldActions
//
//  Created by Mykhailo Kotyk on 08.04.2024.
//
import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        style()
        layout()
    }
    
}



extension ViewController {
    func style() {
        textField.translatesAutoresizingMaskIntoConstraints  = false
        textField.backgroundColor = .secondarySystemFill
        textField.placeholder = "Input some text"
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func layout() {
        view.addSubview(textField)
        
        //textField
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 2),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
    }
}


//MARK: objc func

extension ViewController {
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        
        if let text = sender.text {
            
            print("DEBUG: text in textField = \(text)")
        }
        
    }
}

extension ViewController : UITextFieldDelegate {
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if let text = textField.text {
//            
//            print("DEBUG: text in textField = \(text)")
//        }
//        
//        return true
//    }
}

