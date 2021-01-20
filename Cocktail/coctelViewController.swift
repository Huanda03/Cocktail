//
//  coctelViewController.swift
//  Cocktail
//
//  Created by Mac2 on 19/01/21.
//

import UIKit

class coctelViewController: UIViewController {
    var cocktailManager = CocktailManager2()
    var recibirNombre : String?
    var recibirId: String?
    var idperron : String = ""
    var nombre : String?
    
    @IBOutlet weak var preparacionBebida: UITextView!
    @IBOutlet weak var ImagenBebida: UIImageView!
    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailManager.delegado = self
        cocktailManager.fetchCocktail(cocktail: recibirId!)
    }
    
    
}

extension coctelViewController : CocktailManagerDelegate2{
    func actualizarCocktail2(cocktail: CocktailModelo2) {
        DispatchQueue.main.async {
            self.Label.text = cocktail.nombre
            self.preparacionBebida.text = cocktail.instrucciones
            let url = NSURL(string:cocktail.image!)
            let data = NSData(contentsOf: url as! URL)
            if data != nil {
                self.ImagenBebida.image = UIImage(data:data as! Data)
            }
            
        }
       
    }
    

}


