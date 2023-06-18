//
//  MenuVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 03/05/23.
//

import UIKit

enum NameCell: Int {
    case person = 0
    case configuration = 1
    case darkMode = 2
}

class MenuVC: UIViewController {
    
    var screen: MenuScreen?
    var viewModel: MenuViewModel = MenuViewModel()
    let defauls = UserDefaults.standard
    var nigthKey: String = "isNigth"
    
    override func loadView() {
        self.screen = MenuScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.configTableView(delegate: self, dataSource: self)
        viewModel.addDataMenu()
        //        if let isNigth = defauls.value(forKey: nigthKey) {
        //            if isNigth as! Bool {
        //                switchToNigth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward"), style: .done, target: self, action: #selector(tappedBackButton))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func tappedBackButton(){
        print(#function)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch NameCell(rawValue: indexPath.row) {
        case .person:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsListTableViewCell.identifier, for: indexPath) as? SettingsListTableViewCell
            cell?.setupCell(data: viewModel.dataMenu[indexPath.row])
            return cell ?? UITableViewCell()
        case .configuration:
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingsListTableViewCell.identifier, for: indexPath) as? SettingsListTableViewCell
            cell?.setupCell(data: viewModel.dataMenu[indexPath.row])
            return cell ?? UITableViewCell()
        case .darkMode:
            let cell = tableView.dequeueReusableCell(withIdentifier: DarkModeTableViewCell.identifier, for: indexPath) as? DarkModeTableViewCell
            cell?.setupCell(data: viewModel.dataMenu[indexPath.row])
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
