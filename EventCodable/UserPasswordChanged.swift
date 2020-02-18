//
//  UserPasswordChanged.swift
//  EventCodable
//
//  Created by Robert Walker on 2/18/20.
//  Copyright © 2020 Robert Walker. All rights reserved.
//

import Foundation

enum EventTriggerType: String, Codable {
    case api = "API"
    case system = "System"
    case scim = "SCIM"
}

struct EventTrigger: Codable {
    let type: EventTriggerType
    let source: String
    let accountId: UUID
    let userId: UUID
}

struct EventMetadata: Codable {
    let correlationId: UUID
    let triggeredBy: EventTrigger?
    let version: Int
    let deprecated: Bool
}

struct UserPasswordChanged: Codable {
    let eventId: UUID
    let accountId: UUID
    let actionHistoryTimestamp: Date
    let userId: UUID
    let metadata: EventMetadata?
}
