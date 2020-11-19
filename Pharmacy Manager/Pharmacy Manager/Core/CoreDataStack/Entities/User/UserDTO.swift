//
//  UserDTO.swift
//  Pharmacy
//
//  Created by CGI-Kite on 02.07.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation

struct UserDTO: Equatable, Codable, Identifiable {
    let id: Int
    let name: String
    let email: String?
    let uuid: String
    var avatar: AvatarDTO?

    enum Keys: String, CodingKey {
        case uuid
        case id
        case lastName
        case avatar
        case email
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        id = try container.decode(Int.self, forKey: .id)
        uuid = try container.decode(String.self, forKey: .uuid)
        name = try container.decode(String.self, forKey: .lastName)
        avatar = try? container.decode(AvatarDTO.self, forKey: .avatar)
        email = try? container.decode(String.self, forKey: .email)
    }
}

extension UserDTO: Storable {
    
    var entityType: UserEntity.Type {
        UserEntity.self
    }
    
    var identifier: NSObject {
        NSNumber(value: id)
    }
    
    func fillEntity(entity: UserEntity) {
        entity.updateWith(self)
    }
}
