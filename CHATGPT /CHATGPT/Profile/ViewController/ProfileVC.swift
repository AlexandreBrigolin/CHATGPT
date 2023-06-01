//
//  ProfileVC.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import UIKit

class ProfileVC: UIViewController {
    
    var screen: ProfileScreen?
    var viewModel: ProfileViewModel = ProfileViewModel()
    var data: ProfileUser?
    
    override func loadView() {
        self.screen = ProfileScreen()
        view = screen
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetch(.alamofireRequest)
        setupDataUser()
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

extension ProfileVC: ProfileViewModelDelegate {
    func success() {
        print("deu bom")
    }
    
    func error(_message: String) {
        print("deu ruim \(_message)")
    }
    
    
    
}
