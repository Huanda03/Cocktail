//
//  registrarUsuariosViewController.swift
//  Cocktail
//
//  Created by Mac2 on 14/01/21.
//

import UIKit
import FirebaseAuth

class registrarUsuariosViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var correoTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func registrar(_ sender: UIButton) {
        if
            let email = correoTextField.text,
            let password = contraseñaTextField.text{
            Auth.auth().createUser(withEmail: email, password: password){authResult, error in
                guard let resultado = authResult, error == nil else{
                    guard let error = error else{
                        return
                    }
                    self.alerta(texto: error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                print("Usuario \(resultado.user) registrado")
                self.performSegue(withIdentifier: "registroSegue", sender: self)
            }
        }
        
    }
    
    func alerta (texto : String){
        let mensaje :String
        switch texto {
        case "The password must be 6 characters long or more.":
            mensaje = "La contraseña debe tener al menos 6 caracteres !"
        case "An email address must be provided.":
            mensaje = "Ingrese un correo"
        case "The email address is badly formatted.":
            mensaje = "Formato del correo no valido"
        case "The email address is already in use by another account.":
            mensaje = "El correo ya esta usado por otra cuenta"
        default:
            mensaje = "falta validacion"
        }
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(aceptar)
        present(alerta, animated: true, completion: nil)
    }
}
