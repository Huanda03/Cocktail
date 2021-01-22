//
//  favViewController.swift
//  Cocktail
//
//  Created by Mac2 on 22/01/21.
//

import UIKit
import CoreData

class favViewController : UIViewController{
    
    var nombre : String?
    var id : String?
    
    func conexion() -> NSManagedObjectContext{
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    var favoritos = [Favoritos]()
    
    @IBOutlet weak var tablaFav: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaFav.delegate = self
        tablaFav.dataSource = self
        cargarCoreData()
        tablaFav.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        cargarCoreData()
        tablaFav.reloadData()
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

extension favViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritos.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let contexto = conexion()
            contexto.delete(favoritos[indexPath.row])
            favoritos.remove(at: indexPath.row)
            do{
                try contexto.save()
            }catch _ {
                
            }
        }
        tablaFav.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaFav.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = favoritos[indexPath.row].nombre
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        id = favoritos[indexPath.row].id
        nombre = favoritos[indexPath.row].nombre
        performSegue(withIdentifier: "favCoctel", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favCoctel"{
            let Objcoctel = segue.destination as! favCoctelViewController
            Objcoctel.nombre = nombre
            Objcoctel.id = id
        }
    }
    
}
