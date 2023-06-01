//
//  ProfileViewModel.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import UIKit

enum TypeFetch {
    case alamofireRequest
    case urlSessionRequest
    case mock
}

protocol ProfileViewModelDelegate: AnyObject {
    func success()
    func error(_message: String)
}

class ProfileViewModel: NSObject {
    
    private let service: ProfileService = ProfileService()
    private var getDataUser: ProfileUser?
    
    private weak var delegate: ProfileViewModelDelegate?
    
    public func delegate(delegate: ProfileViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func fetch(_ typeFetch: TypeFetch) {
        switch typeFetch {
        case .alamofireRequest:
            self.service.getProfileAlamofire { success, error in
                if let success = success {
                    self.getDataUser = success
                    self.delegate?.success()
                } else {
                    self.delegate?.error(_message: error?.localizedDescription ?? "")
                }
            }
        case .urlSessionRequest:
            self.service.getProfileUrlSession { success, error in
                if let success = success {
                    self.getDataUser = success
                    self.delegate?.success()
                } else {
                    self.delegate?.error(_message: error?.localizedDescription ?? "")
                }
            }
        case .mock:
            self.service.getProfileFromJson { success, error in
                if let success = success {
                    self.getDataUser = success
                    self.delegate?.success()
                } else {
                    self.delegate?.error(_message: error?.localizedDescription ?? "")
    
                }
            }
        }
    }
    
    public var numberOfRowsInSection: Int {
        return 1
    }
    
    
    var loadCurrentUser: ProfileUser {
        return getDataUser ?? ProfileUser()
    }
    
}
