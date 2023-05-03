//
//  Message.swift
//  CHATGPT
//
//  Created by Caio Fabrini on 26/02/23.
//

import UIKit

enum Status {
    case message
    case photo
}

enum TypeMessage {
    case user
    case chatGPT
}

struct Message {
    var message: String
    var date: Date
    var typeMessage: TypeMessage
}
