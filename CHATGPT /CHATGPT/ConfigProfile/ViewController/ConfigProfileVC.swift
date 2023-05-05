//
//  ConfigProfileVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 05/05/23.
//

import UIKit

class ConfigProfileVC: UIViewController {
    
    var screen: ConfigProfileScreen?
    
    override func loadView() {
        self.screen = ConfigProfileScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
