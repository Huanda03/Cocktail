//
//  CocktailManager2.swift
//  Cocktail
//
//  Created by Mac2 on 20/01/21.
//

import Foundation

protocol CocktailManagerDelegate2 {
    func actualizarCocktail2(cocktail : CocktailModelo2)
}

struct CocktailManager2 {
    
    var delegado : CocktailManagerDelegate2?
        
    let cocktailURL = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?"
    
    func fetchCocktail (cocktail : String){

        let urlString = "\(cocktailURL)i=\(cocktail)"
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
                    if let cocktail = parseJSON2(cocktailData: datosSeguros){
                        delegado?.actualizarCocktail2(cocktail: cocktail)
                    }
                }
            }
            tarea.resume()
        }
    }
    


    func parseJSON2(cocktailData : Data) -> CocktailModelo2?{
        
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(CocktailData.self, from: cocktailData)
            var nombreBebida : String
            var vasoBebida : String
            var instruc : String
            var imagen : String
            var in1 : String?
            var in2 : String?
            var in3 : String?
            var in4 : String?
            var in5 : String?
            var in6 : String?
            var in7 : String?
            var in8 : String?
            var ca1 : String?
            var ca2 : String?
            var ca3 : String?
            var ca4 : String?
            var ca5 : String?
            var ca6 : String?
            var ca7 : String?
            var ca8 : String?
            
            nombreBebida = dataDecodificada.drinks[0].strDrink
            vasoBebida = dataDecodificada.drinks[0].strGlass
            instruc = dataDecodificada.drinks[0].strInstructions
            imagen = dataDecodificada.drinks[0].strDrinkThumb
            in1 = dataDecodificada.drinks[0].strIngredient1
            in2 = dataDecodificada.drinks[0].strIngredient2
            in3 = dataDecodificada.drinks[0].strIngredient3
            in4 = dataDecodificada.drinks[0].strIngredient4
            in5 = dataDecodificada.drinks[0].strIngredient5
            in6 = dataDecodificada.drinks[0].strIngredient6
            in7 = dataDecodificada.drinks[0].strIngredient7
            in8 = dataDecodificada.drinks[0].strIngredient8
            ca1 = dataDecodificada.drinks[0].strMeasure1
            ca2 = dataDecodificada.drinks[0].strMeasure2
            ca3 = dataDecodificada.drinks[0].strMeasure3
            ca4 = dataDecodificada.drinks[0].strMeasure4
            ca5 = dataDecodificada.drinks[0].strMeasure5
            ca6 = dataDecodificada.drinks[0].strMeasure6
            ca7 = dataDecodificada.drinks[0].strMeasure7
            ca8 = dataDecodificada.drinks[0].strMeasure8
            
           
            let objCocktail = CocktailModelo2(nombre: nombreBebida, vaso: vasoBebida, instrucciones: instruc, image: imagen, ingrediente1: in1, ingrediente2: in2, ingrediente3: in3, ingrediente4: in4, ingrediente5: in5, ingrediente6: in6, ingrediente7: in7, ingrediente8: in8, cantidad1: ca1, cantidad2: ca2, cantidad3: ca3, cantidad4: ca4, cantidad5: ca5, cantidad6: ca6, cantidad7: ca7, cantidad8: ca8)
            return objCocktail
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
