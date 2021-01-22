//
//  coctelViewController.swift
//  Cocktail
//
//  Created by Mac2 on 19/01/21.
//

import UIKit
import CoreData

class coctelViewController: UIViewController {
    var cocktailManager = CocktailManager2()
    var recibirNombre : String?
    var recibirId: String?
    var idperron : String = ""
    var nombre : String?
    var entrar : Bool = true
    
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
    @IBOutlet weak var preparacionBebida: UITextView!
    @IBOutlet weak var ImagenBebida: UIImageView!
    @IBOutlet weak var Label: UILabel!
    
    func conexion() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    var favoritos = [Favoritos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarCoreData()
        cocktailManager.delegado = self
        cocktailManager.fetchCocktail(cocktail: recibirId!)
    }
    
    @IBAction func favButton(_ sender: UIBarButtonItem) {
        var num : Int = 0
        for i in 0...favoritos.count-1{
            if favoritos[i].id == recibirId{
                entrar = false
                num=i
            }
        }
        if entrar {
            let alert = UIAlertController(title: "Agregar Favorito", message: "¿Desea agregar este coctel a favoritos?", preferredStyle: .alert)
            
            let aceptar = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                let contexto = self.conexion()
                let entidadFav = NSEntityDescription.insertNewObject(forEntityName: "Favoritos", into: contexto) as! Favoritos
                entidadFav.id = self.recibirId
                entidadFav.nombre = self.recibirNombre
                
                do{
                    try contexto.save()
                }catch let error as NSError{
                    print(error.localizedDescription)
                }
                self.cargarCoreData()
            }
            
            let cancelar = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
            alert.addAction(aceptar)
            alert.addAction(cancelar)
            present(alert, animated: true, completion: nil)
            
        } else{
            let alerta = UIAlertController(title: "Coctel favorito", message: "Desea eliminar este coctel de su lista de favoritos?", preferredStyle: .alert)
            let eliminar = UIAlertAction(title: "Eliminar", style: .destructive) { (_) in
                let contexto = self.conexion()
                contexto.delete(self.favoritos[num])
                self.favoritos.remove(at: num)
                do{
                    try contexto.save()
                }catch _ {
                    
                }
                self.cargarCoreData()
            }
            let cancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alerta.addAction(eliminar)
            alerta.addAction(cancelar)
            present(alerta, animated: true, completion: nil)
        }

    }
    
    func cargarCoreData(){
        let contexto = conexion()
        let fetchRequest : NSFetchRequest <Favoritos> = Favoritos.fetchRequest()
        
        do{
            favoritos = try contexto.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
}

extension coctelViewController : CocktailManagerDelegate2{
    func actualizarCocktail2(cocktail: CocktailModelo2) {
        DispatchQueue.main.async {
            self.Label.text = cocktail.nombre
            self.preparacionBebida.text = cocktail.instrucciones
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
                self.ImagenBebida.image = UIImage(data:data as! Data)
            }
        }
       
    }
    

}


