//
//  CocktailData.swift
//  Cocktail
//
//  Created by Mac2 on 16/01/21.
//

import Foundation

struct CocktailData: Codable{
    let drinks : [drinks]
}

struct drinks: Codable {
    let idDrink : String
    let strDrink : String
    let strGlass : String
    let strInstructions : String
    let strDrinkThumb : String
    let strIngredient1 : String?
    let strIngredient2 : String?
    let strIngredient3 : String?
    let strIngredient4 : String?
    let strIngredient5 : String?
    let strIngredient6 : String?
    let strIngredient7 : String?
    let strIngredient8 : String?
    let strMeasure1 : String?
    let strMeasure2 : String?
    let strMeasure3 : String?
    let strMeasure4 : String?
    let strMeasure5 : String?
    let strMeasure6 : String?
    let strMeasure7 : String?
    let strMeasure8 : String?
}
