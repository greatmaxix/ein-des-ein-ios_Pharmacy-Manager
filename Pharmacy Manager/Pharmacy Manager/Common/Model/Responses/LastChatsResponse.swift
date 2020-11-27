//
//  LastChatsResponse.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation

struct LastChatsResponse: Decodable {

    var items: [Chat]
    var totalCount: Int

    enum Keys: String, CodingKey {
        case items
        case totalCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        items = try container.decode([Chat].self, forKey: .items)
        totalCount = try container.decode(Int.self, forKey: .totalCount)
    }

}

struct LastChat: Codable {

    var id: Int
    var createdAt: String
    var customerName: String?
    var customerAvatar: String?
    var message: String?

    enum Keys: String, CodingKey {
        case createdAt
        case id
        case customer
        case name
        case avatar
        case url
        case text
        case lastMessage
        case totalCount
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        id = try container.decode(Int.self, forKey: .id)
        createdAt = try container.decode(String.self, forKey: .createdAt)

        let customerContainer = try? container.nestedContainer(keyedBy: Keys.self, forKey: .customer)
        customerName = try? customerContainer?.decode(String.self, forKey: .name)

        let avatarContainer = try? container.nestedContainer(keyedBy: Keys.self, forKey: .avatar)
        customerAvatar = try? avatarContainer?.decode(String.self, forKey: .url)

        let messageContainer = try? container.nestedContainer(keyedBy: Keys.self, forKey: .lastMessage)
        message = try? messageContainer?.decode(String.self, forKey: .text)
    }

}
