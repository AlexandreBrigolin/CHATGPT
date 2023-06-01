//
//  ProfileUser.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import Foundation

struct ProfileUser: Codable {
    var prifileImage, profileUserNameUser, nameUser, ageUser: String?
    var phoneUser: String?

    enum CodingKeys: String, CodingKey {
        case prifileImage = "prifile_image"
        case profileUserNameUser = "name_user"
        case nameUser = "@name_user"
        case ageUser = "age_user"
        case phoneUser = "phone_user"
    }
}
