//
//  PrincipalViewController.swift
//  Cocktail
//
//  Created by Mac2 on 14/01/21.
//

import UIKit
import FirebaseAuth

class PrincipalViewController: UIViewController {

    var IDs : [String]?
    var ID : String?
    var nombres : [String]?
    var nombre : String?
    var cocktailManager = CocktailManager()
    
    var coctel = [CocktailModelo]()
    

    @IBOutlet weak var cocktailTextField: UITextField!
    @IBOutlet weak var tablaCoctel: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailManager.delegado = self
        tablaCoctel.dataSource = self
        tablaCoctel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            tablaCoctel.reloadData()
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Cerrar Sesion", message: "Estas seguro que deseas salir ?", preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Salir", style: .destructive) { (_) in
            do{
                try FirebaseAuth.Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popToViewController(ofClass: ViewController.self)
            }catch{
                print(error)
            }
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        alert.addAction(aceptar)
        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
        
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
        IDs = cocktail.id
        nombres = cocktail.nombre
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

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IDs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaCoctel.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = nombres![indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        ID = IDs![indexPath.row]
        nombre = nombres![indexPath.row]
        performSegue(withIdentifier: "coctelInfo", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coctelInfo"{
            let Objcoctel = segue.destination as! coctelViewController
            Objcoctel.recibirNombre = nombre
            Objcoctel.recibirId = ID
        }
    }
    
}
