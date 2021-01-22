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
    
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var idlabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailManager.delegado = self
        cocktailManager.fetchCocktail(cocktail: id!)
        idlabel.text = id
        namelabel.text = nombre
    }


}

extension favCoctelViewController : CocktailManagerDelegate2{
    func actualizarCocktail2(cocktail: CocktailModelo2) {
        DispatchQueue.main.async {

            let url = NSURL(string:cocktail.image!)
            let data = NSData(contentsOf: url as! URL)
            if data != nil {
                self.imagen.image = UIImage(data:data as! Data)
            }
        }
       
    }
    

}
