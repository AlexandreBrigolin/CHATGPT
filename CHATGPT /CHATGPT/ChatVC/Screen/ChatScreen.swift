//
//  ChatScreen.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 26/02/23.
//

import UIKit
import AVFoundation


protocol ChatScreenProtocol: AnyObject {
    func sendMessage(text: String)
    func requestStatus()
}

class ChatScreen: UIView {
    
    var player: AVAudioPlayer?
    private weak var delegate: ChatScreenProtocol?
    
    public func delegate(delegate: ChatScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backGround
        return view
    }()
    
    lazy var messageBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .appLight
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    lazy var sendButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .pink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = UIColor.pink.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(self.tappedSendButton), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        btn.isEnabled = false
        btn.transform = .init(scaleX: 0.8, y: 0.8)
        return btn
    }()
    
    lazy var statusButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .pink
        btn.layer.cornerRadius = 16
        btn.layer.shadowColor = UIColor.pink.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(self.tappedSearchImageButton), for: .touchUpInside)
        btn.imageView?.tintColor = .white
        return btn
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self
        tf.placeholder = "Digite aqui:"
        tf.font = UIFont.helveticaNeueMedium(size: 16)
        tf.textColor = .darkGray
        tf.autocorrectionType = .no
        tf.keyboardType = .asciiCapable
        return tf
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        tableView.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return tableView
    }()
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .backGround
        addElements()
        configConstraints()
        changeRequestStatus(status: .message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(tableView)
        addSubview(messageInputView)
        addSubview(sendButton)
        addSubview(statusButton)
        messageInputView.addSubview(messageBarView)
        messageInputView.addSubview(inputMessageTextField)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
           
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBarView.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
            messageBarView.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
            messageBarView.heightAnchor.constraint(equalToConstant: 55),
            messageBarView.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: messageBarView.trailingAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            sendButton.bottomAnchor.constraint(equalTo: messageBarView.bottomAnchor, constant: -10),
            
            statusButton.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -3),
            statusButton.heightAnchor.constraint(equalToConstant: 40),
            statusButton.widthAnchor.constraint(equalToConstant: 40),
            statusButton.topAnchor.constraint(equalTo: messageBarView.topAnchor, constant: 2),

            inputMessageTextField.leadingAnchor.constraint(equalTo: messageBarView.leadingAnchor,constant: 20),
            inputMessageTextField.trailingAnchor.constraint(equalTo: statusButton.leadingAnchor, constant: -5),
            inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageTextField.centerYAnchor.constraint(equalTo: messageBarView.centerYAnchor)
            
        ])
    }
    
    @objc func tappedSendButton() {
        sendButton.touchAnimation()
        playSound()
        delegate?.sendMessage(text: inputMessageTextField.text ?? "")
        pushMessage()
    }
    
    @objc func tappedSearchImageButton() {
        statusButton.touchAnimation()
        delegate?.requestStatus()
    }
    
    private func pushMessage() {
        inputMessageTextField.text = ""
        sendButton.isEnabled = false
        sendButton.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print("Erro ao tocar o som: \(error.localizedDescription)")
        }
    }
    
    public func reloadTableView() {
        tableView.reloadData()
    }
    
    public func changeRequestStatus(status: RequestStatus) {
        switch status {
        case .message:
            statusButton.setImage(UIImage(systemName: "photo"), for: .normal)
        case .photo:
            statusButton.setImage(UIImage(systemName: "ellipsis.message"), for: .normal)
        }
    }
    
}


extension ChatScreen: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return false }
        let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        
        if txtAfterUpdate.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = false
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.transform = .identity
            }, completion: { _ in
            })
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
