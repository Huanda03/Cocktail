//
//  coctelViewController.swift
//  Cocktail
//
//  Created by Mac2 on 19/01/21.
//

import UIKit

class coctelViewController: PrincipalViewController {
    var recibirNombre : String?
    var recibirId: String?
    
    @IBOutlet weak var Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        Label.text = recibirNombre
    }
    
    
}



