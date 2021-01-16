//
//  ViewController.swift
//  Cocktail
//
//  Created by Mac2 on 13/01/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraseñaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        validarUsuario()
    }

    @IBAction func inicioSesion(_ sender: UIButton) {
        if
            let email = usuarioTextField.text,
            let password = contraseñaTextField.text{
            Auth.auth().signIn(withEmail: email, password: password){authResult, error in
                guard let resultado = authResult, error == nil else{
                    guard let error = error else{
                        return
                    }
                    self.alerta(texto: error.localizedDescription)
                    print(error.localizedDescription)
                    return
                }
                print("Ingreso suario \(resultado.user)")
                self.performSegue(withIdentifier: "inicioSegue", sender: self)
            }
        }
    }
    
    func alerta (texto : String){
        let mensaje :String
        switch texto {
        case "The password is invalid or the user does not have a password.":
            mensaje = "Error en la contraseña"
        case "There is no user record corresponding to this identifier. The user may have been deleted.":
            mensaje = "El correo no corresponde a ningun usuario registrado"
        case "The email address is badly formatted.":
            mensaje = "Correo invalido"
        default:
            mensaje = "falta validacion"
        }
        let alerta = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        let aceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(aceptar)
        present(alerta, animated: true, completion: nil)
    }

    func validarUsuario() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "inicioSegue", sender: self)
        }
    }
    
    @IBAction func crearCuenta(_ sender: UIButton) {
    }
}

