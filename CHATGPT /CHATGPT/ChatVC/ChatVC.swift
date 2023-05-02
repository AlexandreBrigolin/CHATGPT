//
//  ViewController.swift
//  CHATGPT
//
//

import UIKit

class ChatVC: UIViewController {
    
    var viewModel: ChatViewModel = ChatViewModel()
    var screen: ChatScreen?
    
    override func loadView() {
        self.screen = ChatScreen()
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate(delegate: self)
        screen?.configTableView(delegate: self, dataSource: self)
        viewModel.delegate(delegate: self)
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
        reloadTableView()
    }
    
    func error(message: String) {
        reloadTableView()
    }
}

extension ChatVC: ChatScreenProtocol {
    func sendMessage(text: String) {
        viewModel.addMessage(message: text, type: .user)
        reloadTableView()
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
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.setupCell(data: message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow(indexPath: indexPath)
    }
}


