//
//  GenericService.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import Foundation
import Alamofire

protocol GenericService: AnyObject {
    typealias completion <T> = (_ result: T, _ failure: Error?) -> Void
}

enum ErrorProfile: Swift.Error {
    case fileNotFound(name: String)
    case fileDecodingFailed(name: String, Swift.Error)
    case errorRequest(AFError)
    case errorUrl(urlString: String)
    case errorDetail(detail: String)
}
