//
//  MenuVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

class MenuVC: UIViewController {
    
    var screen: MenuScreen?
    
    override func loadView() {
        self.screen = MenuScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.configTableView(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
    }
    

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
