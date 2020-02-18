//
//  UserPasswordChanged2.swift
//  EventCodable
//
//  Created by Robert Walker on 2/19/20.
//  Copyright © 2020 Robert Walker. All rights reserved.
//

import Foundation

enum EventTriggerType2: String, Codable {
    case api = "API"
    case system = "System"
    case scim = "SCIM"
}

struct EventTrigger2: Decodable {
    let type: EventTriggerType2
    let source: String
    let accountId: UUID
    let userId: UUID
}

extension EventTrigger2: Encodable {
    enum CodingKeys: String, CodingKey {
        case type
        case source
        case accountId
        case userId
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(source, forKey: .source)
        try container.encode(accountId.uuidString.lowercased(), forKey: .accountId)
        try container.encode(userId.uuidString.lowercased(), forKey: .userId)
    }
}

struct EventMetadata2: Decodable {
    let correlationId: UUID
    let triggeredBy: EventTrigger2?
    let version: Int
    let deprecated: Bool
}

extension EventMetadata2: Encodable {
    enum CodingKeys: String, CodingKey {
        case correlationId
        case triggeredBy
        case version
        case deprecated
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(correlationId.uuidString.lowercased(), forKey: .correlationId)
        try container.encode(triggeredBy, forKey: .triggeredBy)
        try container.encode(version, forKey: .version)
        try container.encode(deprecated, forKey: .deprecated)
    }
}

struct UserPasswordChanged2: Decodable {
    let eventId: UUID
    let accountId: UUID
    let actionHistoryTimestamp: Date
    let userId: UUID
    let metadata: EventMetadata2?
}

extension UserPasswordChanged2: Encodable {
    enum CodingKeys: String, CodingKey {
        case eventId
        case accountId
        case actionHistoryTimestamp
        case userId
        case metadata
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId.uuidString.lowercased(), forKey: .eventId)
        try container.encode(accountId.uuidString.lowercased(), forKey: .accountId)
        try container.encode(actionHistoryTimestamp, forKey: .actionHistoryTimestamp)
        try container.encode(userId.uuidString.lowercased(), forKey: .userId)
        try container.encode(metadata, forKey: .metadata)
    }
}
