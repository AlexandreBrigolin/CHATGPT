//
//  ServiceManager.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 26/02/23.
//

import UIKit
import OpenAISwift

enum OpenAIError: Error {
    case missingChoiseText
    case apiError(Error)
}

class ServiceManager {
    let openAIModelType: OpenAIModelType = .gpt3(.davinci)
    let token: OpenAISwift = OpenAISwift(authToken: API.authToken)
}
