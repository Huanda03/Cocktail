//
//  PrincipalViewController.swift
//  Cocktail
//
//  Created by Mac2 on 14/01/21.
//

import UIKit

class PrincipalViewController: UIViewController, UITextFieldDelegate {
    
    let cocktailManager = CocktailManager()
    
    @IBOutlet weak var cocktailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailTextField.delegate = self
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        cocktailTextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cocktailManager.fetchCocktail(cocktail: cocktailTextField.text!)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if cocktailTextField.text != ""{
            return true
        }else{
            cocktailTextField.placeholder = "Escribe algo"
            return false
        }
    }
    
    @IBAction func buscarButton(_ sender: UIButton) {
        cocktailManager.fetchCocktail(cocktail: cocktailTextField.text!)
    }
    
}
