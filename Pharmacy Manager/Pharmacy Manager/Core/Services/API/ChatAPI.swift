//
//  ChatAPI.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import Moya

enum ChatAPI {
    enum ChatRoute: String {
        case doctor, pharmacist
    }
    case chatList
    case chatDetails(String)
    case messageList(Int)
    case createMessage(Int, String)
    case create(ChatRoute)
    case lastOpened
    case upload(data: Data, mime: String, name: String)
    case uploadUser(data: Data, mime: String, name: String)
    case sendImage(chatId: Int, uuid: String)
    case createProductMessage(chatId: Int, productId: Int)
    case closeChat(id: Int)
    case continueChat(id: Int)
    case evaluating(chatId: Int, evaluating: ChatEvaluation)
    case lastProducts
    case initiateChatClosing(Int)
}

extension ChatAPI: RequestConvertible {
    var path: String {
        switch self {
        case .chatList: return "chat/chats"
        case .chatDetails(let id): return "customer/chat/\(id)"
        case .messageList(let id): return "chat/chat/\(id)/messages"
        case .createMessage(let id, _): return "chat/chat/\(id)/message"
        case .create: return "customer/chat"
        case .lastOpened: return "user/chat/last-opened-chats"
        case .upload: return "customer/image"
        case .uploadUser: return "customer/image"
        case .sendImage(let chatId, let uuid): return "chat/chat/\(chatId)/application/\(uuid)"
        case .createProductMessage(let chatId, let productId): return "chat/chat/\(chatId)/global-product/\(productId)"
        case .closeChat(let id): return "customer/chat/\(id)/close"
        case .continueChat(let id): return "customer/chat/\(id)/continue"
        case .evaluating(let chatId, _): return "customer/chat/\(chatId)/evaluate"
        case .lastProducts: return "user/chat/last-global-products"
        case .initiateChatClosing(let id): return "user/chat/\(id)/close"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .messageList, .chatList, .chatDetails, .lastOpened, .lastProducts:
            return .get
        case .createMessage, .create, .upload, .uploadUser, .sendImage, .createProductMessage:
            return .post
        case .closeChat, .continueChat, .evaluating, .initiateChatClosing:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .chatDetails, .messageList, .chatList, .sendImage, .createProductMessage, .closeChat, .continueChat, .lastProducts, .initiateChatClosing:
            return .requestPlain
        case .lastOpened:
            return .requestParameters(parameters: ["page": 1, "per_page": 4], encoding: URLEncoding.default)
        case .create(let type):
            return .requestParameters(parameters: ["type": type.rawValue], encoding: JSONEncoding.default)
        case .createMessage(_, let message):
            return .requestParameters(parameters: ["text": message], encoding: JSONEncoding.default)
        case .upload(let data, let mime, let name):
            let formData = [Moya.MultipartFormData(provider: .data(data), name: "file", fileName: name, mimeType: mime)]
            return .uploadMultipart(formData)
        case .uploadUser(let data, let mime, let name):
            let formData = [Moya.MultipartFormData(provider: .data(data), name: "file", fileName: name, mimeType: mime)]
            return .uploadMultipart(formData)
        case .evaluating(_, let evaluating):
            return .requestParameters(parameters: evaluating.asDictionary, encoding: JSONEncoding.default)
        }
    }
}

