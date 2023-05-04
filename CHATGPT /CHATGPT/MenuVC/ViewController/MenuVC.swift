//
//  MenuVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

class MenuVC: UIViewController {
    
    var screen: MenuScreen?
    var viewModel: MenuViewModel = MenuViewModel()
    
    override func loadView() {
        self.screen = MenuScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.configTableView(delegate: self, dataSource: self)
        viewModel.addDataMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
    }
    

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsListTableViewCell.identifier, for: indexPath) as? SettingsListTableViewCell
        cell?.setupCell(data: viewModel.dataMenu[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
