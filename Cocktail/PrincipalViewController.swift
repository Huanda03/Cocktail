//
//  PrincipalViewController.swift
//  Cocktail
//
//  Created by Mac2 on 14/01/21.
//

import UIKit
import FirebaseAuth

class PrincipalViewController: UIViewController {

    var cocktailManager = CocktailManager()
    
    var coctel = [CocktailModelo]()
    

    @IBOutlet weak var cocktailTextField: UITextField!
    @IBOutlet weak var tablaCoctel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailManager.delegado = self
    }

    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do{
            try FirebaseAuth.Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToViewController(ofClass: ViewController.self)
        }catch{
            print(error)
        }
    }
    @IBAction func buscarButton(_ sender: UIButton) {
        cocktailManager.fetchCocktail(cocktail: cocktailTextField.text!)
    }
    
}

extension UINavigationController{
    func popToViewController (ofClass: AnyClass, animated: Bool = true){
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass)}){
            popToViewController(vc, animated: true)
        }
    }
}

extension PrincipalViewController : CocktailManagerDelegate{
    func actualizarCocktail(cocktail: CocktailModelo) {
        print(cocktail.id)
    }
}


extension PrincipalViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        cocktailTextField.text = ""
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
}
