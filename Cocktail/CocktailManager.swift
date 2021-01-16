//
//  CocktailManager.swift
//  Cocktail
//
//  Created by Mac2 on 16/01/21.
//

import Foundation

struct CocktailManager {
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
                    parseJSON(cocktailData: datosSeguros)
                }
                
            }
            tarea.resume()
        }

    }
    
    func parseJSON(cocktailData : Data){
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(CocktailData.self, from: cocktailData)
            print(dataDecodificada.drinks[0].idDrink)
            print(dataDecodificada.drinks[0].strDrink)
            print(dataDecodificada.drinks[0].strGlass)
            print(dataDecodificada.drinks[0].strInstructions)
            print(dataDecodificada.drinks[0].strDrinkThumb)
        }catch{
            print(error.localizedDescription)
        }
       
    }
}
