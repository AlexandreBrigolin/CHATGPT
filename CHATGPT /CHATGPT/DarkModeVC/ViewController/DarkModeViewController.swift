//
//  DarkModeViewController.swift
//  CHATGPT
//
//  Created by Alexandre Brigolin on 10/05/23.
//

import UIKit

class DarkModeViewController: UIViewController {

    var screen: DarkModeScreen?
    var viewModel: DarkModeViewModel = DarkModeViewModel()
    let defauls = UserDefaults.standard
    var nigthKey: String = "isNigth"
    
    override func loadView() {
        self.screen = DarkModeScreen()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screen?.delegate(delegate: self)
        if let isNigth = defauls.value(forKey: nigthKey) {
            if isNigth as! Bool {
                switchToNigth()
            }
        }
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
    
    private func switchToNigth() {
        screen?.mySwitch.setOn(true, animated: false)
        overrideUserInterfaceStyle = .dark
        screen?.backgroundColor = .black
    }
    
    private func switchToDay() {
        screen?.mySwitch.setOn(false, animated: false)
        overrideUserInterfaceStyle = .light
        screen?.backgroundColor = .white
    }
}
extension DarkModeViewController: DarkModeScreenProtocol {
    func tappedSwitchValueChanged(_ sender: Any) {
        print("Modo escuro ativado!")
        if screen?.mySwitch.isOn ?? false {
            switchToNigth()
            defauls.set(true, forKey: nigthKey)
        } else {
            print("Modo claro ativado!")
            switchToDay()
            defauls.set(false, forKey: nigthKey)
        }
    }
}

