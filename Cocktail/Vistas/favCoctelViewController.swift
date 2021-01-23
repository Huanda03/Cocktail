//
//  favCoctelViewController.swift
//  Cocktail
//
//  Created by Mac2 on 22/01/21.
//

import UIKit

class favCoctelViewController: UIViewController {
    var cocktailManager = CocktailManager2()
    
    var nombre : String?
    var id : String?
    
    @IBOutlet weak var preparacion: UITextView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var ing1: UILabel!
    @IBOutlet weak var ing2: UILabel!
    @IBOutlet weak var ing3: UILabel!
    @IBOutlet weak var ing4: UILabel!
    @IBOutlet weak var ing5: UILabel!
    @IBOutlet weak var ing6: UILabel!
    @IBOutlet weak var can1: UILabel!
    @IBOutlet weak var can2: UILabel!
    @IBOutlet weak var can3: UILabel!
    @IBOutlet weak var can4: UILabel!
    @IBOutlet weak var can5: UILabel!
    @IBOutlet weak var can6: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailManager.delegado = self
        cocktailManager.fetchCocktail(cocktail: id!)
        namelabel.text = nombre
    }


}

extension favCoctelViewController : CocktailManagerDelegate2{
    func actualizarCocktail2(cocktail: CocktailModelo2) {
        DispatchQueue.main.async {

            self.preparacion.text = cocktail.instrucciones
            self.ing1.text = cocktail.ingrediente1
            self.ing2.text = cocktail.ingrediente2
            self.ing3.text = cocktail.ingrediente3
            self.ing4.text = cocktail.ingrediente4
            self.ing5.text = cocktail.ingrediente5
            self.ing6.text = cocktail.ingrediente6
            self.can1.text = cocktail.cantidad1
            self.can2.text = cocktail.cantidad2
            self.can3.text = cocktail.cantidad3
            self.can4.text = cocktail.cantidad4
            self.can5.text = cocktail.cantidad5
            self.can6.text = cocktail.cantidad6
            let url = NSURL(string:cocktail.image!)
            let data = NSData(contentsOf: url as! URL)
            if data != nil {
                self.imagen.image = UIImage(data:data as! Data)
            }
        }
       
    }
    

}
