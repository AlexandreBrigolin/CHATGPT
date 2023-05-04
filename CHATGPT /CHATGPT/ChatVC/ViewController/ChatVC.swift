//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit

class ChatVC: UIViewController {
    
    var viewModel: ChatViewModel = ChatViewModel()
    var screen: ChatScreen?
    var loadingView: LoadingView?
    
    override func loadView() {
        self.screen = ChatScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(confgTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func confgTapped(){
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSource: self)
        viewModel.delegate(delegate: self)
        loadingView = LoadingView(controller: self)
    }
    
    func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func reloadTableView() {
        screen?.reloadTableView()
        vibrate()
    }
    
}

extension ChatVC: ChatViewModelProtocol {
    func success() {
        loadingView?.hide()
        reloadTableView()
    }
    
    func error(message: String) {
        loadingView?.hide()
        reloadTableView()
    }
}

extension ChatVC: ChatScreenProtocol {
    
    func requestStatus() {
        viewModel.changeRequestStatus()
        screen?.changeRequestStatus(status: viewModel.getRequestStatus)
    }
    
    func sendMessage(text: String) {
        viewModel.addMessage(message: text, urlImage: nil, type: .user)
        reloadTableView()
        loadingView?.show()
        viewModel.featchMessage(message: text)
    }
}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = viewModel.loadCurrentMessage(indexPath: indexPath)
        switch message.typeMessage {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
        case .chatGPT:
            if message.message != nil {
                let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
                cell?.setupCell(data: message)
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell
                cell?.setupCell(data: message)
                return cell ?? UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(indexPath: indexPath)
    }
}


