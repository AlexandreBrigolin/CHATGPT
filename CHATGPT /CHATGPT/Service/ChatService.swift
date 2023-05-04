//
//  ChatService.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 26/02/23.
//

import UIKit

class ChatService: ServiceManager {
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token.sendCompletion(with: text, model: openAIModelType, maxTokens: 4000, completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.choices?.first?.text else {
                        completion(.failure(.missingChoiseText))
                        return
                    }
                    completion(.success(text))
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        })
    }
    
    func sendOpenAIRequestImage(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token.sendImages(with: text) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    guard let text = model.data?.first?.url else {
                        completion(.failure(.missingChoiseText))
                        return
                    }
                    completion(.success(text))
                case .failure(let error):
                    completion(.failure(.apiError(error)))
                }
            }
        }
    }
    
}
