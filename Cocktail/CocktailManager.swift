//
//  CocktailManager.swift
//  Cocktail
//
//  Created by Mac2 on 16/01/21.
//

import Foundation

protocol CocktailManagerDelegate {
    func actualizarCocktail(cocktail : CocktailModelo)
}

struct CocktailManager {
    
    var delegado : CocktailManagerDelegate?
        
    let cocktailURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?"
    
    func fetchCocktail (cocktail : String){
        let urlString = "\(cocktailURL)s=\(cocktail)"
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString : String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let datosSeguros = data {
                    if let cocktail = parseJSON(cocktailData: datosSeguros){
                        delegado?.actualizarCocktail(cocktail: cocktail)
                    }
                }
                
            }
            tarea.resume()
        }

    }
    
    func parseJSON(cocktailData : Data) -> CocktailModelo?{
        
        
        let decoder = JSONDecoder()
        do{
            
           
            let dataDecodificada = try decoder.decode(CocktailData.self, from: cocktailData)
            
            var nombreBebida = [String]()
            var idBebida = [String]()
            
            for i in 0...dataDecodificada.drinks.count-1{
                idBebida += [dataDecodificada.drinks[i].idDrink]
                nombreBebida += [dataDecodificada.drinks[i].strDrink]
            }
            
            
            let objCocktail = CocktailModelo(id: idBebida, nombre: nombreBebida)
            return objCocktail
            
        
        }catch{
            print(error.localizedDescription)
            return nil
        }
       
    }
}
