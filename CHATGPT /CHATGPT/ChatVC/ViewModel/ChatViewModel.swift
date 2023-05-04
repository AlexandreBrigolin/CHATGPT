//
//  ChatViewModel.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 26/02/23.
//

import UIKit

enum RequestStatus {
    case message
    case photo
}

protocol ChatViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

class ChatViewModel {
    
    private var service: ChatService = ChatService()
    private weak var delegate: ChatViewModelProtocol?
    private var messageList: [Message] = []
    private var requestStatus: RequestStatus = .message
    
    public var getRequestStatus: RequestStatus {
        return requestStatus
    }
    
    public func delegate(delegate: ChatViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func featchMessage(message: String) {
        switch requestStatus {
        case .message:
            service.sendOpenAIRequest(text: message) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    print(success)
                    self.addMessage(message: success, urlImage: nil, type: .chatGPT)
                    self.delegate?.success()
                case .failure(let failure):
                    print(failure.localizedDescription)
                    self.addMessage(message: failure.localizedDescription, urlImage: nil, type: .chatGPT)
                    self.delegate?.error(message: failure.localizedDescription)
                }
            }
        case .photo:
            service.sendOpenAIRequestImage(text: message) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let success):
                    print(success)
                    self.addMessage(message: nil, urlImage: success, type: .chatGPT)
                    self.delegate?.success()
                case .failure(let failure):
                    print(failure.localizedDescription)
                    self.addMessage(message: failure.localizedDescription, urlImage: nil, type: .chatGPT)
                    self.delegate?.error(message: failure.localizedDescription)
                }
            }
        }
    }
    
    public func addMessage(message: String?, urlImage: String?, type: TypeMessage) {
        messageList.insert(Message(message: message?.trimmingCharacters(in: .whitespacesAndNewlines), date: Date(), typeMessage: type, urlImage: urlImage), at: .zero)
    }
    
    public var numberOfRowsInSection: Int {
        return messageList.count
    }
    
    public func loadCurrentMessage(indexPath: IndexPath) -> Message {
        return messageList[indexPath.row]
    }
    
    public func heightForRow(indexPath: IndexPath) -> CGFloat {
        if let message = loadCurrentMessage(indexPath: indexPath).message {
            let font = UIFont.helveticaNeueMedium(size: 16)
            let estimateHeight = message.heightWithConstrainedWidth(width: 220, font: font)
            return estimateHeight + 65
        } else {
            return 265
        }
    }
    
    public func changeRequestStatus() {
        if requestStatus == .message {
            requestStatus = .photo
        } else {
            requestStatus = .message
        }
    }

}
