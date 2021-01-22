//
//  favCoctelViewController.swift
//  Cocktail
//
//  Created by Mac2 on 22/01/21.
//

import UIKit

class favCoctelViewController: UIViewController {
    
    var nombre : String?
    var id : String?
    
    @IBOutlet weak var idlabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        idlabel.text = id
        namelabel.text = nombre
    }


}
