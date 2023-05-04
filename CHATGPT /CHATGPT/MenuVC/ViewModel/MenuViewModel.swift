//
//  MenuViewModel.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

class MenuViewModel {
    
    var dataMenu: [Menu] = []
    
    public func addDataMenu() {
        dataMenu.append(Menu(descriptionText: "Bárbara Brigolin", descriptionImage: UIImage(systemName: "person") ?? UIImage()))
        dataMenu.append(Menu(descriptionText: "Configurações de Tela", descriptionImage: UIImage(systemName: "sun.and.horizon") ?? UIImage()))
    }
    
    public var numberOfRowsInSection: Int {
        return dataMenu.count
    }

}
